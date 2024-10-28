Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985F1EE012
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730156198; cv=none; b=BijcmaSw9ufzIn4Gl66q0bUknK2vkKyciepRLmfdRJSu+x5Z2MUFnz1VYMu2XDnAi3ljIuYLpUIbPJMN9EhlkcpUaRpbCteDauE17OYHxS3HjQ07YqxZ8xiFI+K+lCXJ5ucVYMuhwGufLNncdlw5XOgS69KBkHlfsZ1ueZ5U3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730156198; c=relaxed/simple;
	bh=o6pZVgQYnL1vcAt6O3B5rF0BAekC75DsbuXyHvigxyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFvurvqlpxv53FLUOVE+nhVSbRsvzY9JofrGUTkhdu0eqEJfnpii9zd9rb0ath5E0BEtt+q6ytiGb6IPqzTFy/NVeE9pcrnONrxSCQTARVcMk5pOwYRKQuMbDwshRK5fh37mf7ouMPozVRo9jUS/MMpmlT6AtvZVgQs/vd7cdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qv7Nu2ZM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qv7Nu2ZM"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so7515751a12.2
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 15:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730156195; x=1730760995; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVirlTRNThIlw5izD//IoFLz8dbGPSlaVi5YQ6nWJuM=;
        b=Qv7Nu2ZMQdOLBz6ghWOCA1jwvM85YUgqNbAjGwkBAKx3qXnTo5jOox5s8rgJ+TzOV5
         1pM4O80zw/eQ5txYpBf4J/KoOErOHjTLVbJxAFF+7gMNyebD89D72OL1jgK+SD5APGBV
         VxJBBQ8owgvIvRuKGs7MoKjtiFUXHSM0Txkh+1KN6YXtQeCvjC8gltLiWu0inQA1iqYo
         Te+kNNnMcBADUIt1e/m52P+regQ40J6beAlTdQWGihniK24cCEVpPpHAPlAa4MzQdfAW
         wDgpoq9bgpiziusyqhURDHL1aXni5REp8HxfVNHPYDTzedfNMwqQxHsqdXU77iytWIQ7
         aX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730156195; x=1730760995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVirlTRNThIlw5izD//IoFLz8dbGPSlaVi5YQ6nWJuM=;
        b=qjcbaqR6SyOfLwRsl+3s8uv6/v1ZkM9l00guyxTjVTzQR+65A2oZp11jwSaVqPIWO0
         AQo+JFks9XJFfFDWfbo9gtyeOqs0pfY+VtJpA0+Ma9wFM6DEgV1PYbnf9I5rE+Dd2ROq
         V7Ofbs47+B9ucMpdUXReEF348Ll2kv9g7Qsfmtn7z4HG0DdEy7D61FjxP6QCpevAyFfP
         gQYeHUNTmppHA7iVIDNiSO21gCr3rqWE/I0om4Skuwl1P1gJbAFE1tCnX3qxwJyM9iai
         jx99EXzI/dBm9Q8PlyjoZ2652ViAPCBUZ7IjfVNmEcimFTvJoaqyaPacQdPa4HR7dOCB
         2sKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLqXTqXh80Lf80XK1U/Go0DtihhiaxAVv/oqZaP4GG3Uyu5gG0Zy80IK0A0eCL275U5ScTkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuG3JGnJQloWGlfD48YufE97EYmzX2BTtXTRT0oemODOQKcqa+
	uY5IIvsPWJRNkmdY4gGS2iVEFYS2KYc3ZAyAFjQA5M5JxPR4EsBiTk++8MI/sDeywgWUS8Obgka
	efHUWtWg6yiuPQ39ygV1LEtaWfEaFVZbUJLj6lw==
X-Google-Smtp-Source: AGHT+IF+nARq3xO0Wchcpvg4D+JUkbPZjSN4wHXbnO04jBNcQohZsJW3DXYyIkia0+QEiSgA8N9blw/TGhiEe8MkXiY=
X-Received: by 2002:a05:6402:13c7:b0:5c9:547d:99 with SMTP id
 4fb4d7f45d1cf-5cbbf889742mr8302467a12.2.1730156194611; Mon, 28 Oct 2024
 15:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1730136799.git.robin.murphy@arm.com> <831CC29D-3B89-4091-8145-0E310FF838CB@goldelico.com>
In-Reply-To: <831CC29D-3B89-4091-8145-0E310FF838CB@goldelico.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 28 Oct 2024 16:56:23 -0600
Message-ID: <CANLsYkyUCwb5RF378VWwW0axiOU1RT4oTa_sTTL+jSqVF5DawQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix omap-iommu bitrot
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, mchehab@kernel.org, 
	andersson@kernel.org, Beleswar Padhi <b-padhi@ti.com>, 
	Andreas Kemnade <andreas@kemnade.info>, iommu@lists.linux.dev, 
	arm-soc <linux-arm-kernel@lists.infradead.org>, 
	Linux-OMAP <linux-omap@vger.kernel.org>, linux-media@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, 
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 14:46, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Robin,
>
> > Am 28.10.2024 um 18:58 schrieb Robin Murphy <robin.murphy@arm.com>:
> >
> > Hi all,
> >
> > It seems omap-iommu hasn't had enough mainline users to avoid bitrotting
> > through the more recent evolution of the IOMMU API internals. These
> > patches attempt to bring it and its consumers sufficiently up-to-date
> > to work again, in a manner that's hopefully backportable. This is
> > largely all written by inspection, but I have managed to lightly boot
> > test patch #3 on an OMAP4 Pandaboard to confirm iommu_probe_device()
> > working again.
> >
> > This supersedes my previous patch[1]. Patches #1 and #2 are functionally
> > independent, and can be applied directly to their respective trees if
> > preferred.
>
> I can confirm that this series works on omap3 with v6.12-rc5 and
> Camera is back to the GTA04.
>
> So you can add:
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
>

Many thanks for taking the time to test this, it is really appreciated.

> BR and thanks,
> Nikolaus
>
> root@letux:~# dmesg|fgrep iommu
> [    0.522613] iommu: Default domain type: Translated
> [    0.522644] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.525177] omap-iommu 480bd400.mmu: 480bd400.mmu registered
> [   10.752563] omap3isp 480bc000.isp: Adding to iommu group 0
> [   10.811218] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
> [   11.039489] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
> root@letux:~# dmesg|fgrep .isp
> [   10.752563] omap3isp 480bc000.isp: Adding to iommu group 0
> [   10.841522] omap3isp 480bc000.isp: supply vdd-csiphy1 not found, using dummy regulator
> [   10.948577] omap3isp 480bc000.isp: supply vdd-csiphy2 not found, using dummy regulator
> [   10.990814] omap3isp 480bc000.isp: Revision 15.0 found
> [   11.089324] omap3isp 480bc000.isp: hist: using DMA channel dma0chan15
> [   11.115905] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CCP2 was not initialized!
> [   11.168792] omap3isp 480bc000.isp: isp_xclk_set_rate: cam_xclka set to 24685714 Hz (div 7)
> [   11.220062] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CSI2a was not initialized!
> [   11.291748] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP CCDC was not initialized!
> [   11.362152] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP preview was not initialized!
> [   11.404266] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP resizer was not initialized!
> [   11.485687] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP AEWB was not initialized!
> [   11.520874] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP AF was not initialized!
> [   11.574981] omap3isp 480bc000.isp: Entity type for entity OMAP3 ISP histogram was not initialized!
> [   11.594268] omap3isp 480bc000.isp: parsing parallel interface
> [  106.102905] omap3isp 480bc000.isp: -------------CCDC Register dump-------------
> [  106.110595] omap3isp 480bc000.isp: ###CCDC PCR=0x00000000
> [  106.116973] omap3isp 480bc000.isp: ###CCDC SYN_MODE=0x00031704
> [  106.123657] omap3isp 480bc000.isp: ###CCDC HD_VD_WID=0x00000000
> [  106.129974] omap3isp 480bc000.isp: ###CCDC PIX_LINES=0x00000000
> [  106.136810] omap3isp 480bc000.isp: ###CCDC HORZ_INFO=0x000004ff
> [  106.143615] omap3isp 480bc000.isp: ###CCDC VERT_START=0x00000000
> [  106.149932] omap3isp 480bc000.isp: ###CCDC VERT_LINES=0x000003ff
> [  106.156799] omap3isp 480bc000.isp: ###CCDC CULLING=0xffff00ff
> [  106.163299] omap3isp 480bc000.isp: ###CCDC HSIZE_OFF=0x00000a00
> [  106.169616] omap3isp 480bc000.isp: ###CCDC SDOFST=0x00000000
> [  106.176086] omap3isp 480bc000.isp: ###CCDC SDR_ADDR=0x40000000
> [  106.182708] omap3isp 480bc000.isp: ###CCDC CLAMP=0x00000010
> [  106.188598] omap3isp 480bc000.isp: ###CCDC DCSUB=0x00000000
> [  106.195068] omap3isp 480bc000.isp: ###CCDC COLPTN=0xbb11bb11
> [  106.201507] omap3isp 480bc000.isp: ###CCDC BLKCMP=0x00000000
> [  106.207550] omap3isp 480bc000.isp: ###CCDC FPC=0x00000000
> [  106.213684] omap3isp 480bc000.isp: ###CCDC FPC_ADDR=0x00000000
> [  106.219909] omap3isp 480bc000.isp: ###CCDC VDINT=0x03fe02aa
> [  106.226409] omap3isp 480bc000.isp: ###CCDC ALAW=0x00000006
> [  106.232696] omap3isp 480bc000.isp: ###CCDC REC656IF=0x00000000
> [  106.238830] omap3isp 480bc000.isp: ###CCDC CFG=0x00008800
> [  106.244964] omap3isp 480bc000.isp: ###CCDC FMTCFG=0x00000000
> [  106.251434] omap3isp 480bc000.isp: ###CCDC FMT_HORZ=0x00000000
> [  106.257568] omap3isp 480bc000.isp: ###CCDC FMT_VERT=0x00000000
> [  106.264251] omap3isp 480bc000.isp: ###CCDC PRGEVEN0=0x00000000
> [  106.271606] omap3isp 480bc000.isp: ###CCDC PRGEVEN1=0x00000000
> [  106.285400] omap3isp 480bc000.isp: ###CCDC PRGODD0=0x00000000
> [  106.301147] omap3isp 480bc000.isp: ###CCDC PRGODD1=0x00000000
> [  106.307220] omap3isp 480bc000.isp: ###CCDC VP_OUT=0x00000000
> [  106.326019] omap3isp 480bc000.isp: ###CCDC LSC_CONFIG=0x00006600
> [  106.340087] omap3isp 480bc000.isp: ###CCDC LSC_INITIAL=0x00000000
> [  106.358001] omap3isp 480bc000.isp: ###CCDC LSC_TABLE_BASE=0x00000000
> [  106.372985] omap3isp 480bc000.isp: ###CCDC LSC_TABLE_OFFSET=0x00000000
> [  106.379882] omap3isp 480bc000.isp: --------------------------------------------
> [  118.617980] omap3isp 480bc000.isp: OMAP3 ISP AEWB: user wants to disable module.
> [  118.626068] omap3isp 480bc000.isp: OMAP3 ISP AEWB: module is being disabled
> [  118.633392] omap3isp 480bc000.isp: OMAP3 ISP AF: user wants to disable module.
> [  118.641937] omap3isp 480bc000.isp: OMAP3 ISP AF: module is being disabled
> [  118.649627] omap3isp 480bc000.isp: OMAP3 ISP histogram: user wants to disable module.
> [  118.658508] omap3isp 480bc000.isp: OMAP3 ISP histogram: module is being disabled
> root@letux:~#
>
>
>
