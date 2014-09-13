From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v4 1/1] iommu/arm-smmu: Do not access non-existing S2CR
 registers
Date: Sat, 13 Sep 2014 08:36:53 -0700
Message-ID: <54146495.8020609@codeaurora.org>
References: <1408752752-15601-1-git-send-email-ohaugan@codeaurora.org> <20140826103730.GE23445@arm.com> <20140828105552.GI22580@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140828105552.GI22580@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 8/28/2014 3:55 AM, Will Deacon wrote:
> On Tue, Aug 26, 2014 at 11:37:30AM +0100, Will Deacon wrote:
>> On Sat, Aug 23, 2014 at 01:12:32AM +0100, Olav Haugan wrote:
>>> The number of S2CR registers is not properly set when stream
>>> matching is not supported. Fix this and add check that we do not try to
>>> access outside of the number of S2CR regisrers.
>>
>> Sorry for the bother, but could you base this on either iommu/devel or
>> iommu/staging please? Now that the merge window is well and truly over, I
>> moved those branches forward, so you needn't worry about iommu/pci anymore
>> (which, as you pointed out, contains a bunch of WIP patches which should
>> hold-up useful fixes like this one).
> 
> Actually, it looks like this was eaten by our sorry excuse for an email
> service. I've managed to apply a version from the archive, thanks.
> 

Thanks Will. Sorry for the late reply. I have been OoO.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
