Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685363C3B
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 07:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8ABC4339B;
	Tue,  9 May 2023 07:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1683617527;
	bh=hqRuZTZKPLhm1SCs6rtoJIIQr2UoRO/eHbuyOeqFpCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGF8ucgxJ76Y1V0eKtU8tCTnpak94aLBJX/zyqcCTSgvljCowz58Dx42OvNNZDJKY
	 eA4mHv1pd0yKBIcuvOpgkm5sb7ATDslllYBS4vl+JLlPk/V9UyKZeVmX69qWV+Lwz5
	 e+f3EUR1dQi4etSA11immNQ1FGWQ8vsfVbNbi08Q=
Date: Tue, 9 May 2023 09:32:03 +0200
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
Message-ID: <2023050949-grueling-verify-a43b@gregkh>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz>
 <2023042617-wobble-enlighten-9361@gregkh>
 <20230426144439.5674f8bc@meshulam.tesarici.cz>
 <20230509091635.27450bd9@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509091635.27450bd9@meshulam.tesarici.cz>

On Tue, May 09, 2023 at 09:16:35AM +0200, Petr Tesařík wrote:
> On Wed, 26 Apr 2023 14:44:39 +0200
> Petr Tesařík <petr@tesarici.cz> wrote:
> 
> > Hi Greg,
> > 
> > On Wed, 26 Apr 2023 14:26:36 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Wed, Apr 26, 2023 at 02:15:20PM +0200, Petr Tesařík wrote:  
> > > > Hi,
> > > > 
> > > > On Wed, 19 Apr 2023 12:03:52 +0200
> > > > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> > > >     
> > > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > > > 
> > > > > The goal of my work is to provide more flexibility in the sizing of
> > > > > SWIOTLB.
> > > > > 
> > > > > The software IO TLB was designed with these assumptions:
> > > > > 
> > > > > 1. It would not be used much, especially on 64-bit systems.
> > > > > 2. A small fixed memory area (64 MiB by default) is sufficient to
> > > > >    handle the few cases which require a bounce buffer.
> > > > > 3. 64 MiB is little enough that it has no impact on the rest of the
> > > > >    system.
> > > > > 
> > > > > First, if SEV is active, all DMA must be done through shared
> > > > > unencrypted pages, and SWIOTLB is used to make this happen without
> > > > > changing device drivers. The software IO TLB size is increased to
> > > > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > > > approximation. The actual requirements may vary depending on the
> > > > > amount of I/O and which drivers are used. These factors may not be
> > > > > know at boot time, i.e. when SWIOTLB is allocated.
> > > > > 
> > > > > Second, other colleagues have noticed that they can reliably get
> > > > > rid of occasional OOM kills on an Arm embedded device by reducing
> > > > > the SWIOTLB size. This can be achieved with a kernel parameter, but
> > > > > determining the right value puts additional burden on pre-release
> > > > > testing, which could be avoided if SWIOTLB is allocated small and
> > > > > grows only when necessary.    
> > > > 
> > > > Now that merging into 6.4 has begun, what about this patch series? I'm
> > > > eager to get some feedback (positive or negative) and respin the next
> > > > version.    
> > > 
> > > It's the merge window, we can't add new things that haven't been in
> > > linux-next already.  
> > 
> > This is understood. I'm not asking for immediate inclusion.
> > 
> > >   Please resubmit it after -rc1 is out.  
> > 
> > If you can believe that rebasing to -rc1 will be enough, then I will
> > also try to believe I'm lucky. ;-)
> > 
> > The kind of feedback I really want to get is e.g. about the extra
> > per-device DMA-specific fields. If they cannot be added to struct
> > device, then I'd rather start discussing an interim solution, because
> > getting all existing DMA fields out of that struct will take a lot of
> > time...
> 
> All right, 6.4-rc1 is out now. The patch series still applies cleanly.
> 
> Any comments what must be changed (if anything) to get it in?

Try resending it, it's long out of my review queue...

thanks,

greg k-h
