Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC130C433EF
	for <iommu@archiver.kernel.org>; Sun,  3 Jul 2022 15:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B23460BD2;
	Sun,  3 Jul 2022 15:36:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B23460BD2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qm4eCiLF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 69VkwBT-cAbO; Sun,  3 Jul 2022 15:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09F7260AAE;
	Sun,  3 Jul 2022 15:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09F7260AAE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB31C0032;
	Sun,  3 Jul 2022 15:36:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ADF5C002D
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5714405E5
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5714405E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Qm4eCiLF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ede5HCql4xMF for <iommu@lists.linux-foundation.org>;
 Sun,  3 Jul 2022 15:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23066405C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23066405C6
 for <iommu@lists.linux-foundation.org>; Sun,  3 Jul 2022 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656862573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oMrNKP/vCBD/e31gpGg6HfkwO33FSse+0JtWS4WTRVo=;
 b=Qm4eCiLFFuf0rnxI6nQ8cds6/A9pJkURY2h9zcvcZ83fZKUIx1l3jhx6TPQyCb2pUHI/in
 Ivp5AECEEn5vyGPQg0BZzCt78Rf7amMokZJ3uKr71LPdXnXTq0WTfuF7E2c+71f5hKY2JZ
 dZlMx+Lb2T4tG19VFADXjO9Y18RXKrI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-SeokIBgRO1mSbyk621tZOQ-1; Sun, 03 Jul 2022 11:36:10 -0400
X-MC-Unique: SeokIBgRO1mSbyk621tZOQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so3291196wma.4
 for <iommu@lists.linux-foundation.org>; Sun, 03 Jul 2022 08:36:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oMrNKP/vCBD/e31gpGg6HfkwO33FSse+0JtWS4WTRVo=;
 b=an1IdvU4Ovt3LjODieQ00Zr/2s59nS2scJzaTbg/5TY1Z7Eah2adQls4RBke9k52/f
 vMO0qQeJ/LWlxJHKwqBycnjRL4SB53wEvs+h6Zxw9AE46HWpxE3XgIhQelNwAG7xJaYI
 0Q+PXIg5j5GLBnLdMFhBXzX9E+tTqSk4qegHRPiaNu+zP4cr/BwTs+bQfng55CjRqdd5
 VdRmKsfCDDiCEoA5OnzIMZXLlbeZpT7q4Ukvd1lUWIPSRMu49g6rl1bNLNBN58dP758M
 XbGWj4WwEyfsvBL/y9rj52QkQ+ajx4auQ5ecMe/R54SJen4I6kN0gf4pnbquIFMeAAsN
 QuSw==
X-Gm-Message-State: AJIora+jSeCiF/7U/MJwCc6WrT3G7SajUmWMNRPr2+rcQOGpRpLgcU4Y
 gFXZ9MWDfxVqoJOS5Qoxbhcug7AclBmuElEEfGSM+lsMc8yLhUEOLf0dABJ7//+kb1H5nidg91E
 J9Ww+WfLH8zryfvFqbsQrgLlFhLpN
X-Received: by 2002:a05:600c:3658:b0:3a0:390e:ea00 with SMTP id
 y24-20020a05600c365800b003a0390eea00mr26241432wmq.128.1656862569475; 
 Sun, 03 Jul 2022 08:36:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1slUbbrZARxOKqEcZqRJ7u3lLS226MuMPP/AWfWU5makabF0z0BDsEcPRojyiptS+6qPf8yiw==
X-Received: by 2002:a05:600c:3658:b0:3a0:390e:ea00 with SMTP id
 y24-20020a05600c365800b003a0390eea00mr26241418wmq.128.1656862569321; 
 Sun, 03 Jul 2022 08:36:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net.
 [82.17.115.212]) by smtp.gmail.com with ESMTPSA id
 a3-20020a056000100300b0021b943a50b3sm28301105wrx.85.2022.07.03.08.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Jul 2022 08:36:05 -0700 (PDT)
Date: Sun, 3 Jul 2022 16:36:04 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, hpa@zytor.com
Subject: Re: [RFC PATCH 3/3] iommu/vt-d: Show region type in
 arch_rmrr_sanity_check()
Message-ID: <20220703153604.pmgdrsaszmcwtpa7@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220611204859.234975-1-atomlin@redhat.com>
 <20220611204859.234975-3-atomlin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220611204859.234975-3-atomlin@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=atomlin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 atomlin@atomlin.com
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

On Sat 2022-06-11 21:48 +0100, Aaron Tomlin wrote:
> This patch will attempt to describe the region type in the event
> that a given RMRR entry is not within a reserved region.

Any thoughts?


Kind regards,

-- 
Aaron Tomlin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
