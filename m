From: Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH] iommu/amd: Fix schedule-while-atomic BUG in
 initialization code
Date: Wed, 26 Jul 2017 15:25:05 +0200
Message-ID: <20170726132505.cw4xmstcrbmuduyz@shodan.usersys.redhat.com>
References: <20170725135618.hev4vj7w24gm3a5q@shodan.usersys.redhat.com>
 <alpine.DEB.2.20.1707261241220.2186@nanos>
 <20170726122614.GP15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726122614.GP15833@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 26, 2017 at 02:26:14PM +0200, Joerg Roedel wrote:
> Hi Artem, Thomas,
> 
> On Wed, Jul 26, 2017 at 12:42:49PM +0200, Thomas Gleixner wrote:
> > On Tue, 25 Jul 2017, Artem Savkov wrote:
> > 
> > > Hi,
> > > 
> > > Commit 1c3c5ea "sched/core: Enable might_sleep() and smp_processor_id()
> > > checks early" seem to have uncovered an issue with amd-iommu/x2apic.
> > > 
> > > Starting with that commit the following warning started to show up on AMD
> > > systems during boot:
> >  
> > > [    0.160000] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747 
> > 
> > > [    0.160000]  mutex_lock_nested+0x1b/0x20 
> > > [    0.160000]  register_syscore_ops+0x1d/0x70 
> > > [    0.160000]  state_next+0x119/0x910 
> > > [    0.160000]  iommu_go_to_state+0x29/0x30 
> > > [    0.160000]  amd_iommu_enable+0x13/0x23 
> > > [    0.160000]  irq_remapping_enable+0x1b/0x39 
> > > [    0.160000]  enable_IR_x2apic+0x91/0x196 
> > > [    0.160000]  default_setup_apic_routing+0x16/0x6e 
> > > [    0.160000]  native_smp_prepare_cpus+0x257/0x2d5
> 
> Thanks for the report!
> 
> > --- a/drivers/iommu/amd_iommu_init.c
> > +++ b/drivers/iommu/amd_iommu_init.c
> > @@ -2440,7 +2440,6 @@ static int __init state_next(void)
> >  		break;
> >  	case IOMMU_ACPI_FINISHED:
> >  		early_enable_iommus();
> > -		register_syscore_ops(&amd_iommu_syscore_ops);
> >  		x86_platform.iommu_shutdown = disable_iommus;
> >  		init_state = IOMMU_ENABLED;
> >  		break;
> > @@ -2559,6 +2558,8 @@ static int __init amd_iommu_init(void)
> >  			for_each_iommu(iommu)
> >  				iommu_flush_all_caches(iommu);
> >  		}
> > +	} else {
> > +		register_syscore_ops(&amd_iommu_syscore_ops);
> >  	}
> >  
> >  	return ret;
> 
> Yes, that should fix it, but I think its better to just move the
> register_syscore_ops() call to a later initialization step, like in the
> patch below. I tested it an will queue it to my iommu/fixes branch.

Checked it as well just in case, didn't see any issues. Thank you.

Reported-and-tested-by: Artem Savkov <asavkov@redhat.com>

-- 
Regards,
  Artem
