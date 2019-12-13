Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C136DC43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BA82253D
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmvuOLY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BA82253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE70485F54;
	Fri, 13 Dec 2019 14:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1I92-wMbBeNY; Fri, 13 Dec 2019 14:31:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 363A585C4C;
	Fri, 13 Dec 2019 14:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 197F4C1D7F;
	Fri, 13 Dec 2019 14:31:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78C42C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 14:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 61D97872F8
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 14:31:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eD6N-U0r64JF for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 14:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B70FA8695F
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 14:31:39 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id a203so2193213qkc.3
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ykZo3kG5ISYmLvjiMpJlkxot5ywM3Vp6sip1X77Jcyw=;
 b=ZmvuOLY2OLj5gJEZSCS9MLSflO3nur5U4G0jfmS3Vi4JUEXPLq1mO1hniQJWD3i1MM
 UsEfpzKFKlfr1t2rfpsf0EOIEqQZWQji91CsYnjndbmkIkUNaXYbHcJrwVh/8jk+y+UK
 dESEyoWyxC3OKowZygAEzHIlHH8uj5ScAqkS3I40xzMZRW7d1mU2UtGI20G+752MgVEn
 +WWDbc2kP7cAmnZkD11zQ9oLwOfPQcm9cLTY2GMJMisxkvc0AfUzzDcMmraRIP4ZAzdU
 mBcf4MKtRdpyhmhUfgBuAcz1TbrshSGS63P+qTy3xlYE9Yp8qgcUqe9Nsai26KGMpJyL
 Iaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ykZo3kG5ISYmLvjiMpJlkxot5ywM3Vp6sip1X77Jcyw=;
 b=SE1heVAc7mujtxIDptvI1e14MpH2nuHJD9f3+rJLHShxmPhkoeRqb0L+sJ7BXI6W3d
 D48/RC/TPKVOhAnzRvFolPtZOWiF9JNNyIrsOMJh7wToUyA54KXTNvbNfGGPe2cN42Uf
 GMDmUOTM8YOh7ekeJ1RM74AZO0ORXc/Vd+JAGFAxgMJCds1pav8TOyyXyqMYsm3x356G
 sZqlNWoS+LsDACLOZ6+0ZVHCc9tTazSMLELBr5rdJB9sYb0L5l/86TSz7HlhTXulK/9p
 uSjMCG6FwmAFhGN6HRkAXQYkSueqULAWSPEVcE9a6Lq1QZ+nizFAyqKSDkYhICT+b7AT
 HS2Q==
X-Gm-Message-State: APjAAAUMbKjMGlTxA9PgsC9ErEmEJUIK4zkqqWrrhHTdRGFXnDh5hCrl
 h7sBqvrQ+8iKaQywmJe44hvJfg==
X-Google-Smtp-Source: APXvYqwZoU/9A01lyXQsE83D/uJ3Rhf4+zPgybuF9pUjpWSaeFFDYMW6+CIC83P4hM0EufocBt2YlQ==
X-Received: by 2002:a37:274a:: with SMTP id n71mr11692954qkn.302.1576247498387; 
 Fri, 13 Dec 2019 06:31:38 -0800 (PST)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net.
 [66.30.119.151])
 by smtp.gmail.com with ESMTPSA id v7sm3467318qtk.89.2019.12.13.06.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:31:37 -0800 (PST)
Subject: Re: [PATCH 0/3] iommu/vt-d bad RMRR workarounds
To: Lu Baolu <baolu.lu@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
References: <20191211194606.87940-1-brho@google.com>
 <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
Message-ID: <8a530d5c-22e1-3c2f-98df-45028cc6c771@google.com>
Date: Fri, 13 Dec 2019 09:31:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <35f49464-0ce5-9998-12a0-624d9683ea18@linux.intel.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/11/19 9:43 PM, Lu Baolu wrote:
> The VT-d spec defines the BIOS considerations about RMRR in section 8.4:
> 
> "
> BIOS must report the RMRR reported memory addresses as reserved (or as
> EFI runtime) in the system memory map returned through methods such as
> INT15, EFI GetMemoryMap etc.
> "
> 
> So we should treat it as firmware bug if the RMRR range is not mapped as
> RESERVED in the system memory map table.
> 
> As for how should the driver handle this case, ignoring buggy RMRR with
> a warning message might be a possible choice.

Agreed, firmware should not be doing this.  My first patch just skips 
those entries, instead of aborting DMAR processing, and keeps the warning.

So long as the machine still boots in a safe manner, I'm reasonably happy.

Thanks,

Barret


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
