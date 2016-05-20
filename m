From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH V4 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Fri, 20 May 2016 16:48:26 +0530
Message-ID: <001301d1b289$58e56f70$0ab04e50$@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org> <3070591.xyl7SB8DB7@wuerfel> <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org> <2638968.1a16UdaY62@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: 
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, iommu@lists.linux-foundation.org, robdclark@gmail.com, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

>>
>>If you need the barrier after the write, it probably was already faulty
>>before, because writel only implies a barrier before the store, not
>>after. Of course all the barriers likely made the whole process so
>>slow that you never hit that race in the end.
>
>ya, it could have worked in this way and i never saw a race issue before this.
>The only reason for changing this was to optimise out the additonal barriers
>that were happening. I do not see any issue now as well, only that the writes would
>be faster.
>
 I reposted a patch here [1] with comments, i had to delete the
old accessors though as it became unused now.

http://www.spinics.net/lists/arm-kernel/msg505448.html

Regards,
 Sricharan
