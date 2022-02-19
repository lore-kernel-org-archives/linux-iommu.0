Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD01C433EF
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 17:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3117D400B8;
	Sat, 19 Feb 2022 17:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gvZTA5fi4a5r; Sat, 19 Feb 2022 17:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B3E824018A;
	Sat, 19 Feb 2022 17:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54CE5C0011;
	Sat, 19 Feb 2022 17:54:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7347C000B
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:54:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9346B4018A
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:54:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hUSTPJn-SxCr for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:54:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B3D30400B8
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:54:29 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id m14so11190128lfu.4
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=aoZkz4UcqkbcbdkBIaYothPTAVInA8f47sKV7OByCA8=;
 b=V05F1qg9f4nbiwXkgAbj6ZupT1vhyiVl+oRG2Cb72we2lGfczwVY5Hrsq7P5izsqOX
 Jzh5Xj+Gwz6iNZ2fw601ehpiQ+HttwigtxD5rOh2KVkMMnaFIQ6eOQpVT3RBZe8nT+1S
 3RtcX5CTCmsgG88DqViob+rNiEN6HGEcaaRmNvUyhLGZiLwv7jcaRgIGQfCLvy/sKMPp
 Z4DtHnEzaP7/oGctss4mUdtZ7ucRZv2phgcJBBoqIgc68C6qig8bdTiPZJy5tLB5vJvb
 dPjcJPN9hXsMvugSHTwQgtFfAOJEdNIxR5fOtKAlEdPFAyXr2lAtUizSi/gfJMgcbg4s
 bLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aoZkz4UcqkbcbdkBIaYothPTAVInA8f47sKV7OByCA8=;
 b=T8uoaxaZyGF7R57+D0tHYHNSG/lNCwT5RvcipzhcPpOHDPPXYW4s714UsqN0vClE4e
 vIBqT+gIDLjR20USq6LPxQWg6L/3cpmh2vnIkY+G0MOYlXk9lu6M+Vz2D9+wwNRSrdbn
 G14WaxQnc0dcBrrKKTKvseykcWHNqgPm6LAvh5Yj0qV2BnyNGi9wM5IRynECLAV1eOFx
 36htOS4kwOiE5Lenl+1NmLCeDRNGKUsTiFh67g34pLlSdJfyqzblQEMUygk+7a0BLewt
 95Hn9nUA/Jy0SUxKAjXQG8Zn+jfCJDyXXLD/PLCzDltuXUQVfAShYHU/WV6qpxqohHh3
 NdwQ==
X-Gm-Message-State: AOAM532O77H3W2hb1gqfAmOZUL3vB6zC+e4NIG0rfRRhCMDnNCz82FkG
 uPfkMvUzHjXTMgXyr9GFRmE=
X-Google-Smtp-Source: ABdhPJyZm5rpdUuzDAVCO59dU5XnbDOQjopGFqtKzdhrYSb/gAp9nQZmNiw36/eNkNYap3Bi46Jbbg==
X-Received: by 2002:a05:6512:220b:b0:42a:1481:a977 with SMTP id
 h11-20020a056512220b00b0042a1481a977mr8836563lfu.293.1645293267754; 
 Sat, 19 Feb 2022 09:54:27 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id f19sm390690lfh.264.2022.02.19.09.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 09:54:27 -0800 (PST)
Message-ID: <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
Date: Sat, 19 Feb 2022 20:54:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Content-Language: en-US
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-3-mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gK2NvbmZpZyBU
RUdSQV9IT1NUMVhfQ09OVEVYVF9CVVMKPiArCWJvb2wKPiArCj4gIGNvbmZpZyBURUdSQV9IT1NU
MVgKPiAgCXRyaXN0YXRlICJOVklESUEgVGVncmEgaG9zdDF4IGRyaXZlciIKPiAgCWRlcGVuZHMg
b24gQVJDSF9URUdSQSB8fCAoQVJNICYmIENPTVBJTEVfVEVTVCkKPiAgCXNlbGVjdCBETUFfU0hB
UkVEX0JVRkZFUgo+ICsJc2VsZWN0IFRFR1JBX0hPU1QxWF9DT05URVhUX0JVUwoKV2hhdCBpcyB0
aGUgcG9pbnQgb2YgVEVHUkFfSE9TVDFYX0NPTlRFWFRfQlVTIGlmIGl0J3Mgc2VsZWN0ZWQKdW5j
b25kaXRpb25hbGx5PwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
