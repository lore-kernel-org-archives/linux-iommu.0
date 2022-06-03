Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B453C433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Jun 2022 15:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEB5F842AE;
	Fri,  3 Jun 2022 15:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0a4hpD4AbgEu; Fri,  3 Jun 2022 15:25:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AA97181A2B;
	Fri,  3 Jun 2022 15:25:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B8F7C0039;
	Fri,  3 Jun 2022 15:25:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45401C002D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 15:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26DDC81423
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 15:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qQtm65LY3TfQ for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jun 2022 15:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80AA38141A
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jun 2022 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654269295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSS+WlIjCzxfASZfHJ/pG+nFg5xuEcmHlF7DakY9wuE=;
 b=IsinTjFKocoU3Ir/OHyQ6Oh5fbnyNiUT0IrjR3r/vh1Ebm70qJu6KsVg0TvWQPMS9Y/zK8
 hJsYRXG6abjPlOC3unxoSCr6yIlrOjV5D0LyTky8Ot7cF65FJGxD3z4jnTu33d4WGJxKo9
 D/hmP8DLKDqZfiLyTGT0W6Gx+tT+sfY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-l7ZVOGzWOLWs1R0mjU44KQ-1; Fri, 03 Jun 2022 11:14:53 -0400
X-MC-Unique: l7ZVOGzWOLWs1R0mjU44KQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 o18-20020a05620a2a1200b006a0cc3d8463so6181432qkp.4
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jun 2022 08:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KSS+WlIjCzxfASZfHJ/pG+nFg5xuEcmHlF7DakY9wuE=;
 b=sAd3VRFOYeuuPOnn8TF4I3fKfhBhSO85zqcacDwbMGlyr7Sd5xLKAa6CsS3k4lHH60
 7boS7wGaET3/3EMQA1CzDyswgrQumqrc7AtkcROykRtNK8uOGdEM/GoYxcHV8tJRUP4H
 AlgFutKaGNNQXRg3q2uCFkElj0Y3MjJtP49CmHR17CiwoZRwxIMxj63Jq1RX5mzkp9tP
 n2p7fItTp7Z/JVz8JqpozR2idBho6zDaezN30FH3bqEI9C/bAcnWcpBk2Eo6by1AH2vC
 sjEsvvhIPEBGjYSkNUWoISJVcRgJ42NIVcEol1Zoygrmy3ZqULsDdFVLObiZIafxhLKS
 YFCQ==
X-Gm-Message-State: AOAM5328FYvQI1/p1edT+HnFrLlQWK004/rBI5B5tZaogL1FU8SEkmPX
 1mUGbnDGVeyG+wYG2BRF6qETQWm6l4k7SgVhNnIS6M/NF026HvswjONrOJJEr/3X5TFHxXbsr5U
 mv3qOiE0nMBcNFW+2FYDkaTVxDE4SWg==
X-Received: by 2002:a05:620a:1445:b0:6a3:9f13:7f10 with SMTP id
 i5-20020a05620a144500b006a39f137f10mr6753069qkl.736.1654269293268; 
 Fri, 03 Jun 2022 08:14:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYV+OzB2BFz+1kTFY3RgS+1hrEcN6pQQortBLwObPtwEpeMeMFxrV3fG5J5vUdP1DDnfWMew==
X-Received: by 2002:a05:620a:1445:b0:6a3:9f13:7f10 with SMTP id
 i5-20020a05620a144500b006a39f137f10mr6753042qkl.736.1654269292985; 
 Fri, 03 Jun 2022 08:14:52 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a05620a215c00b006a03cbb1323sm5009016qkm.65.2022.06.03.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jun 2022 08:14:52 -0700 (PDT)
Date: Fri, 3 Jun 2022 11:14:51 -0400
From: Brian Masney <bmasney@redhat.com>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 5/6] iommu/qcom: Index contexts by asid number to allow
 asid 0
Message-ID: <Ypola4mBuQ6zDLcz@xps13>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-6-konrad.dybcio@somainline.org>
MIME-Version: 1.0
In-Reply-To: <20220527212901.29268-6-konrad.dybcio@somainline.org>
User-Agent: Mutt/2.2.1 (2022-02-19)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmasney@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 03 Jun 2022 15:25:21 +0000
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 jamipkettunen@somainline.org, iommu@lists.linux-foundation.org,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 27, 2022 at 11:29:00PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This driver was indexing the contexts by asid-1, which is probably
> done under the assumption that the first ASID is always 1.
> 
> Unfortunately this is not entirely true: at least in the MSM8956
> and MSM8976 GPU IOMMU, the gpu_user context's ASID number is zero.
> To allow using an asid number of zero, stop indexing the contexts
> by asid-1 and rather index them by asid.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>

msm8974 will need this as well.

Reviewed-by: Brian Masney <bmasney@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
