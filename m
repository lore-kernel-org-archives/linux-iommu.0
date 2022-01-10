Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72167C433EF
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 18:44:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 077C74012B;
	Mon, 10 Jan 2022 18:44:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULC5Ow_qYKHk; Mon, 10 Jan 2022 18:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8F0940620;
	Mon, 10 Jan 2022 18:44:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E7C5C0030;
	Mon, 10 Jan 2022 18:44:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 601FDC001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 438B340347
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BbItufZ28Y1q for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 18:44:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D3AF400CB
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 18:44:03 +0000 (UTC)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20AIhwRD024096;
 Mon, 10 Jan 2022 12:43:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1641840238;
 bh=GXFv+aD2Z2QpT9wkKsMxpEH3rvlER44XWUwe0K4BQGo=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=Q19vHUXdIct9YXddCk9aYe0mYdaZr5u/dtOqG0+gTBRxSAJ7v2eLzAxZTwe1nncKv
 HRudZ1ATy/XaLUflANitx63S+X/Eez2b8yLr8CjaesjjmT0aRoHEhgEHaE58Bwafgs
 g/1Sw72x/HJIyNP2il0WJp4gUdPDcqFBZwzBCq3I=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20AIhwuF017932
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Jan 2022 12:43:58 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 10
 Jan 2022 12:43:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 10 Jan 2022 12:43:58 -0600
Received: from [10.249.36.164] (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20AIhvjn023819;
 Mon, 10 Jan 2022 12:43:57 -0600
Subject: Re: [PATCH] iommu/omap: Fix missing put_device() call in
 omap_iommu_probe_device
To: Miaoqian Lin <linmq006@gmail.com>
References: <20220107080428.10873-1-linmq006@gmail.com>
 <de3a3e1c-6c51-e951-cc7f-9ce2ccb3f283@ti.com>
 <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
Message-ID: <fd659736-2106-1be3-084b-7caddf2dc18e@ti.com>
Date: Mon, 10 Jan 2022 12:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110022531.GA61@VICKYMQLIN-NB1.localdomain>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: "Nagalla, Hari" <hnagalla@ti.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Miaoqian,

On 1/9/22 8:43 PM, Miaoqian Lin wrote:
> Hi Suman Anna,
> On Fri, Jan 07, 2022 at 08:42:16AM -0600, Suman Anna wrote:
>> Hi Miaoqian,
>>
>>
>>> Add the corresponding 'put_device()' in the error handling paths.
>>
>> Also, need it in the regular path, not just in error handling path.
> I think after calling platform_get_drvdata() normally, the
> reference will be released in other functions, so don't need it in the
> regular path.
> 

No, it's a local reference and is acquired within omap_iommu_probe_device() and
needs to be released within this function. What other function are you referring
to here?

regards
Suman

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
