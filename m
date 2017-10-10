From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/vt-d: Don't register bus-notifier under
Date: Tue, 10 Oct 2017 09:21:41 +0200
Message-ID: <20171010072141.57vbnmg4crpsk6ip@suse.de>
References: <4e9f9665-38f7-c5f0-2a9d-13bb3a00aab2@siemens.com>
 <6ed4183a-b2eb-b8d3-c54c-fb0c4fd7a813@siemens.com>
 <82afec06-4eb9-7b91-7b19-c442b77b5769@siemens.com>
 <20171006130823.a4rtzhusjpbgo3ar@suse.de>
 <2ee59dfe-0a02-05b6-8115-5846b49bc053@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2ee59dfe-0a02-05b6-8115-5846b49bc053@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 09, 2017 at 06:58:13PM +0200, Jan Kiszka wrote:
> >  extern int dmar_table_init(void);
> >  extern int dmar_dev_scope_init(void);
> > +extern void dmar_register_bus_notifier(void);
> >  extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
> >  				struct dmar_dev_scope **devices, u16 segment);
> >  extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
> > 
> 
> Silences the warning, but locking in the init paths still smells fishy
> to me.

Yes, its certainly not optimal, but the code that runs in there also
runs at iommu hotplug time, so we can't just remove the locking there
entirely.

On the other side the warning you reported is a false-positive, it can
never dead-lock because the reverse lock-order happens only at
initialization time, but I don't know how to silence it otherwise.


Regards,

	Joerg
