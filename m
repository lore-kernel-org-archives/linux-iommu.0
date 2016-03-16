From: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [RFT] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Wed, 16 Mar 2016 12:16:57 +0200
Message-ID: <CAFCwf13LM+snV1Hi+hE4yHHRKRTzoySNHNesM+2vxAKFYzvqVg@mail.gmail.com>
References: <1458079926-18716-1-git-send-email-mcgrof@kernel.org>
 <CAFCwf13RT9VyzhJ4AhAGd1ndd8f=Cd0TRnnRcDwBGHbOzyc5BQ@mail.gmail.com> <20160316101457.GC2195@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160316101457.GC2195@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, iommu@lists.linux-foundation.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 12:14 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Wed, Mar 16, 2016 at 09:02:43AM +0200, Oded Gabbay wrote:
>> fwiw, we currently have this covered by the ugly hack of putting iommu
>> subsystem in front of gpu subsystem in the main drivers makefile (See
>> 1bacc894c227fad8a727eb99728df708eba57654)
>
> Sure, but the above is a less ugly hack to solve the problem. So the
> question is, would that work too?
>
>
>         Joerg
>

In theory it should, but I would prefer that it would be tested on
actual hardware.

     Oded
