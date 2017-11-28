From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Add debugfs extension to show
 register contents
Date: Tue, 28 Nov 2017 14:15:51 +0200
Message-ID: <1511871351.25007.460.camel@linux.intel.com>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
         <1511378746-109275-5-git-send-email-sohil.mehta@intel.com>
         <1511385559.25007.415.camel@linux.intel.com>
         <2824B99DC70CE746926327C52CA42F76378EA17D@ORSMSX111.amr.corp.intel.com>
         <1511827411.2717.9.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511827411.2717.9.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Mehta, Sohil" <sohil.mehta@intel.com>, "Kammela, Gayatri" <gayatri.kammela@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2017-11-28 at 00:02 +0000, Mehta, Sohil wrote:
> On Mon, 2017-11-27 at 20:52 +0000, Kammela, Gayatri wrote:
> > 
> > > 
> > > From: Andy Shevchenko [mailto:andriy.shevchenko@linux.intel.com]
> > > Sent: Wednesday, November 22, 2017 1:19 PM
> > >  
> > > Moreover, see the patch I have just sent [1] and use same
> > > DEFINE_SHOW_ATTRIBUTE() macro here. In that case we would easily
> > > move it
> > > to seq_file.h for everyone to use in the future.
> > 
> > That makes sense! I see your patch is not merged yet, so really
> > cannot reuse the same macro. I will have to redefine it.
> 
> Thanks Andy. That's a good suggestion. Are you planning to move the
> macro to seq_file.h soon? If so, should we include this marco in our
> patch after it has been merged?

Yes, I sent v2 [1] where it's moved to seq_file.h and asked Bluetooth maintainer to create an immutable branch for other subsystems.
So far the response is to roll back to v1 AFAIU.

[1]:  https://patchwork.ozlabs.org/cover/840899/

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
