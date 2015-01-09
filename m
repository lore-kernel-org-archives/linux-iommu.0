From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [v3 00/26] Add VT-d Posted-Interrupts support
Date: Fri, 9 Jan 2015 13:46:16 +0100
Message-ID: <20150109124616.GB17298@8bytes.org>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <E959C4978C3B6342920538CF579893F002327907@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F002327907@SHSMSX104.ccr.corp.intel.com>
Sender: kvm-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Feng,

On Tue, Jan 06, 2015 at 01:10:19AM +0000, Wu, Feng wrote:
> Ping...
> 
> Hi Joerg & David,
> 
> Could you please have a look at the IOMMU part of this series (patch 02 - 04, patch 06 - 09 , patch 26)?
> 
> Hi Thomas, Ingo, & Peter,
> 
> Could you please have a look at this series, especially for patch 01, 05, 21?

I fear this conflicts somewhat with the irq-domain patches from Jiang
Liu. Once we worked this out (should happen soon) I'll have a look at
the VT-d posted interrupt patches.

Regards,

	Joerg

