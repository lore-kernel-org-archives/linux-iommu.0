Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BCEC4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:04:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07C720758
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJtZfY19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07C720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D3E6273CF;
	Fri,  2 Oct 2020 18:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oog6VnditbC7; Fri,  2 Oct 2020 18:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D8A84204D4;
	Fri,  2 Oct 2020 18:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C452EC0889;
	Fri,  2 Oct 2020 18:04:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB1BCC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4A9486C07
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8S5Zaf6BMRP3 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 18:04:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EC48B86A07
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 18:04:34 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id 77so2948200lfj.0
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E9bgZxYv/RxOeJOXWw7426mT+7GbY13hZGXLbKnQnYw=;
 b=iJtZfY19TrniD8h6LVpwXQn4bQdTtYlCkB15ZZDFY5ziTHHV5/ugU9dpZ+n+a/ERuj
 wQsbUbibEdLoh2fFAQiOuQOkwytpq0Vg3Pv/xKcddMPnkB7WU9JUC5MYsPuEZiJnfUGd
 4QF3US5PQ8ofVdHAMEZq452OzNSgi05+YD+qYwR9HpNXiNgko8cyVbtyfF1duWz0zwjh
 GhbQpj46bZT28MWjOGvAQp4PNuXxDD5D73eXdvXQBhApXx4r4Poyvw3TqTZdbNZNGXNi
 aPB15/efAvaCc2m0FIH5s223YF5fbiKS1XmA/OXdqan6KL5JhZbNToW1wHkCbZ0/iD0C
 pncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E9bgZxYv/RxOeJOXWw7426mT+7GbY13hZGXLbKnQnYw=;
 b=Ssvk6iafE2ZWr3M9pylxs6QMWHP4oIz/VNSse7UKyme3Sine/xWT0lnlM8bS/PwEuI
 k163V17G8oYzOwickuzPze/PlaL1/Q6zQkSgdr6e6SHQiCTrU2QkheZEccCA9WjD0dHv
 bGPDA6HoyzBI9kAqx6G59oyBkRt33BnKXZVpPJoixAFCglbmR3Hr7XZZ2zZxgC60ETMN
 8IZQ/7HbSsbfAkEAQGWXL9mV13ZlTGx81el6lq3Pa6bX2Sl63lQLd7qcek4MBHG3R6+q
 VRJlcuyhcHfFw6mDsQMHs+oqjb3iWARt3o0v70+ZLXZT62Jg8cd4p+MtaoxXbEIaDo8E
 Ovzw==
X-Gm-Message-State: AOAM533Dfn2HX6NQKfAUO4flVzbYak3hWhdTvDCPPOK/AykwavXXBNoE
 Y1lOxxzEhhLBWEzs1d2SZCA=
X-Google-Smtp-Source: ABdhPJwYWn5ZEXsgsJyPwVGhib96/ISyH1PDMH0P6JD3SZBGoy/27BBjnJal2G/WWHFCRV+BspS++w==
X-Received: by 2002:a19:f245:: with SMTP id d5mr1170281lfk.97.1601661873255;
 Fri, 02 Oct 2020 11:04:33 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-252.nat.spd-mgts.ru.
 [109.252.91.252])
 by smtp.googlemail.com with ESMTPSA id r4sm444396lfc.162.2020.10.02.11.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 11:04:32 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-4-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6668f545-a2d5-120d-f34d-57f0ed1bbddf@gmail.com>
Date: Fri, 2 Oct 2020 21:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002060807.32138-4-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MDIuMTAuMjAyMCAwOTowOCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gVGhpcyBwYXRjaCBz
aW1wbHkgYWRkcyBzdXBwb3J0IGZvciBQQ0kgZGV2aWNlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBO
aWNvbGluIENoZW4gPG5pY29sZW90c3VrYUBnbWFpbC5jb20+Cj4gLS0tCgpSZXZpZXdlZC1ieTog
RG1pdHJ5IE9zaXBlbmtvIDxkaWdldHhAZ21haWwuY29tPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
