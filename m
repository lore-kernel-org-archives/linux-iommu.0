From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 1/3] mm: alloc_contig_range: allow to specify GFP mask
Date: Fri, 27 Jan 2017 17:19:04 +0100
Message-ID: <20170127161904.GA6357@dhcp22.suse.cz>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <81849c0d-b7aa-faf2-484c-66b0ea0a7e95@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lucas Stach <l.stach@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Graf <agraf@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de
List-Id: iommu@lists.linux-foundation.org

On Fri 20-01-17 13:35:40, Vlastimil Babka wrote:
> On 01/19/2017 06:07 PM, Lucas Stach wrote:
[...]
> > @@ -7255,7 +7256,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
> >  		.zone = page_zone(pfn_to_page(start)),
> >  		.mode = MIGRATE_SYNC,
> >  		.ignore_skip_hint = true,
> > -		.gfp_mask = GFP_KERNEL,
> > +		.gfp_mask = gfp_mask,
> 
> I think you should apply memalloc_noio_flags() here (and Michal should
> then convert it to the new name in his scoped gfp_nofs series). Note
> that then it's technically a functional change, but it's needed.
> Otherwise looks good.

yes, with that added, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> >  	};
> >  	INIT_LIST_HEAD(&cc.migratepages);
> >  
> > 

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
