Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49921FA7
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 12:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C57C433EF;
	Wed, 26 Apr 2023 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1682511999;
	bh=cdI2zaKgoeVH8+lh7QkDEcGOwMPtzMzzDqC1Ob1nKds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnOqm7ybgwu+DC68iZtWPjdOTym6MH7XxTN2/p31qzx99QWiUJFxjFpek/am/RsjL
	 J78JpEkD/lO49If6n8utrPfZrNtelum+LW9DYynU1hPJC7QnHXYzPZdECqdd0aVD7D
	 VlWhKvBu7PcmbTjDYaHQSB/lz1VE7E3fYaXez6xA=
Date: Wed, 26 Apr 2023 14:26:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Kim Phillips <kim.phillips@amd.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Muchun Song <muchun.song@linux.dev>, Ondrej Zary <linux@zary.sk>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Won Chung <wonchung@google.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <2023042617-wobble-enlighten-9361@gregkh>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426141520.0caf4386@meshulam.tesarici.cz>

On Wed, Apr 26, 2023 at 02:15:20PM +0200, Petr Tesařík wrote:
> Hi,
> 
> On Wed, 19 Apr 2023 12:03:52 +0200
> Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> 
> > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > 
> > The goal of my work is to provide more flexibility in the sizing of
> > SWIOTLB.
> > 
> > The software IO TLB was designed with these assumptions:
> > 
> > 1. It would not be used much, especially on 64-bit systems.
> > 2. A small fixed memory area (64 MiB by default) is sufficient to
> >    handle the few cases which require a bounce buffer.
> > 3. 64 MiB is little enough that it has no impact on the rest of the
> >    system.
> > 
> > First, if SEV is active, all DMA must be done through shared
> > unencrypted pages, and SWIOTLB is used to make this happen without
> > changing device drivers. The software IO TLB size is increased to
> > 6% of total memory in sev_setup_arch(), but that is more of an
> > approximation. The actual requirements may vary depending on the
> > amount of I/O and which drivers are used. These factors may not be
> > know at boot time, i.e. when SWIOTLB is allocated.
> > 
> > Second, other colleagues have noticed that they can reliably get
> > rid of occasional OOM kills on an Arm embedded device by reducing
> > the SWIOTLB size. This can be achieved with a kernel parameter, but
> > determining the right value puts additional burden on pre-release
> > testing, which could be avoided if SWIOTLB is allocated small and
> > grows only when necessary.
> 
> Now that merging into 6.4 has begun, what about this patch series? I'm
> eager to get some feedback (positive or negative) and respin the next
> version.

It's the merge window, we can't add new things that haven't been in
linux-next already.   Please resubmit it after -rc1 is out.

thanks,

greg k-h
