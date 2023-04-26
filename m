Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAB1FA7
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 12:15:34 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id AAF5B1638D9;
	Wed, 26 Apr 2023 14:15:22 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1682511323; bh=pe2UYZizOeio6nSoi1Td4szdHUc2e4dqr0KHdYi4A/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kK6XN5om/s4+bL7JgU298eKq8z6ZaYnBhwZ6NHI/7cfcpx+CraI/5CnKciTYPRDaE
	 oNRqFdAQetZP/ZEYqzaMm4g8P7dpOMOdjbMCZ3kfK5KMmuo6JEDZUWA1mjcJk+uJda
	 jq0GI99tm0lPRCrtchUwW5dZR6RwTmoI0T0ZxWrF1i4NXTyYgwKiMjsR1xHFwr0WdF
	 jPYPa50+d84XT3FoddAgv4HS5tAFbFRukSwNOLD6ytM6AWFbu39ZOxAEuCKrPCXFpS
	 R7uOHvYVM5cwzThS34J7vf4y0Jz7GKapbhm91/CG2E/4bhAcuRL3rckqwB4Apsk9UJ
	 vMVuxLErWtiGg==
Date: Wed, 26 Apr 2023 14:15:20 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Borislav Petkov <bp@suse.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, Randy
 Dunlap <rdunlap@infradead.org>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, Kim Phillips <kim.phillips@amd.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, Muchun Song
 <muchun.song@linux.dev>, Ondrej Zary <linux@zary.sk>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, Petr Tesarik <petr.tesarik.ext@huawei.com>, Hans de
 Goede <hdegoede@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Kees Cook
 <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Won Chung
 <wonchung@google.com>, linux-doc@vger.kernel.org (open list:DOCUMENTATION),
 linux-kernel@vger.kernel.org (open list), dri-devel@lists.freedesktop.org
 (open list:DRM DRIVERS), iommu@lists.linux.dev (open list:DMA MAPPING
 HELPERS), Roberto Sassu <roberto.sassu@huawei.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230426141520.0caf4386@meshulam.tesarici.cz>
In-Reply-To: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 19 Apr 2023 12:03:52 +0200
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The goal of my work is to provide more flexibility in the sizing of
> SWIOTLB.
> 
> The software IO TLB was designed with these assumptions:
> 
> 1. It would not be used much, especially on 64-bit systems.
> 2. A small fixed memory area (64 MiB by default) is sufficient to
>    handle the few cases which require a bounce buffer.
> 3. 64 MiB is little enough that it has no impact on the rest of the
>    system.
> 
> First, if SEV is active, all DMA must be done through shared
> unencrypted pages, and SWIOTLB is used to make this happen without
> changing device drivers. The software IO TLB size is increased to
> 6% of total memory in sev_setup_arch(), but that is more of an
> approximation. The actual requirements may vary depending on the
> amount of I/O and which drivers are used. These factors may not be
> know at boot time, i.e. when SWIOTLB is allocated.
> 
> Second, other colleagues have noticed that they can reliably get
> rid of occasional OOM kills on an Arm embedded device by reducing
> the SWIOTLB size. This can be achieved with a kernel parameter, but
> determining the right value puts additional burden on pre-release
> testing, which could be avoided if SWIOTLB is allocated small and
> grows only when necessary.

Now that merging into 6.4 has begun, what about this patch series? I'm
eager to get some feedback (positive or negative) and respin the next
version.

Petr T
