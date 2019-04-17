From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] iommu/mediatek: fix leaked of_node references
Date: Wed, 17 Apr 2019 15:33:53 +0200
Message-ID: <13cb52b9-2e41-2b47-96cd-37748de86531@web.de>
References: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555468879-34684-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Matthias Brugger <mbrugger@suse.com>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: iommu@lists.linux-foundation.org

> The call to of_parse_phandle returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.

Can a splitting of this information into two sentences help?


> 581 static int mtk_iommu_probe(struct platform_device *pdev)
> 582 {
>     ...

I suggest to reconsider such a commit description once more.
Would it be better to mention that another function call should be added
in two if branches so that the exception handling would be completed
(instead of copying source code where a software update should become
clear also from the provided diff hunk)?

Regards,
Markus
