From: "Kinney, Steven" <Steven.Kinney@amd.com>
Subject: RE: [PATCH 1/3] AMD x86 quirks: Quirk for enabling IOMMUv2 PC
 feature
Date: Mon, 28 Jan 2013 14:59:25 +0000
Message-ID: <57D41218901B4442B4AFF404D21591163C2D4E@sausexdag02.amd.com>
References: <1358799658-6236-1-git-send-email-steven.kinney@amd.com>
 <1358799658-6236-2-git-send-email-steven.kinney@amd.com>
 <20130128142928.GZ25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130128142928.GZ25591@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Myron Stowe <myron.stowe@redhat.com>, Hiroshi DOYU <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Jiri Kosina <jkosina@suse.cz>, Kukjin Kim <kgene.kim@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Thomas Renninger <trenn@suse.de>, Andi Kleen <ak@linux.intel.com>, Cyrill Gorcunov <gorcunov@openvz.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

                       It was disabled for a reason that does not pertain to IOMMUv2 PC static counts (reading from the ICounter associated with the selected bank/counter).  Testing with perf shows expected results.

Thanks,

Steve

-----Original Message-----
From: Joerg Roedel [mailto:joro@8bytes.org] 
Sent: Monday, January 28, 2013 8:29 AM
To: Kinney, Steven
Cc: Thomas Gleixner; Ingo Molnar; H. Peter Anvin; x86@kernel.org; Bjorn Helgaas; Greg Kroah-Hartman; Sebastian Andrzej Siewior; Myron Stowe; Hiroshi DOYU; Stephen Warren; Jiri Kosina; Kukjin Kim; linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; Peter Zijlstra; Paul Mackerras; Arnaldo Carvalho de Melo; Thomas Renninger; Andi Kleen; Cyrill Gorcunov
Subject: Re: [PATCH 1/3] AMD x86 quirks: Quirk for enabling IOMMUv2 PC feature

On Mon, Jan 21, 2013 at 02:20:56PM -0600, Steven L. Kinney wrote:
> From: "Steven L. Kinney" <steven.kinney@amd.com>
> 
> Original code base by Andreas Herrmann at AMD with minor changes.

Why is it safe to enable this feature when it was disabled by BIOS? Was it disabled for no reason?


	Joerg
