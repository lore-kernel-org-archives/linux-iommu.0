From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v3 00/26] Add VT-d Posted-Interrupts support
Date: Fri, 9 Jan 2015 13:58:20 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002336FD8@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <E959C4978C3B6342920538CF579893F002327907@SHSMSX104.ccr.corp.intel.com>
 <20150109124616.GB17298@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150109124616.GB17298@8bytes.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: joro@8bytes.org [mailto:joro@8bytes.org]
> Sent: Friday, January 09, 2015 8:46 PM
> To: Wu, Feng
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> alex.williamson@redhat.com; jiang.liu@linux.intel.com; eric.auger@linaro.org;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> kvm@vger.kernel.org
> Subject: Re: [v3 00/26] Add VT-d Posted-Interrupts support
> 
> Hi Feng,
> 
> On Tue, Jan 06, 2015 at 01:10:19AM +0000, Wu, Feng wrote:
> > Ping...
> >
> > Hi Joerg & David,
> >
> > Could you please have a look at the IOMMU part of this series (patch 02 - 04,
> patch 06 - 09 , patch 26)?
> >
> > Hi Thomas, Ingo, & Peter,
> >
> > Could you please have a look at this series, especially for patch 01, 05, 21?
> 
> I fear this conflicts somewhat with the irq-domain patches from Jiang
> Liu. Once we worked this out (should happen soon) I'll have a look at
> the VT-d posted interrupt patches.
> 
> Regards,
> 
> 	Joerg

Thanks a lot for your feedback on this. In fact, my patches is based on Jiang Liu's
irq-domain patches and has been discussed with Jiang offline. So I don't think
it will conflicts with Jiang's work. Anyway, any comments are welcome!

Thanks,
Feng

