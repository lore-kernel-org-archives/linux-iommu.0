Return-Path: <SRS0=m57D=Z3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5A4C43603
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:26:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17972053B
	for <iommu@archiver.kernel.org>; Thu,  5 Dec 2019 02:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJGnPO6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17972053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E86487F8A;
	Thu,  5 Dec 2019 02:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1Lf7TIxmUTh; Thu,  5 Dec 2019 02:26:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6FB7E87F76;
	Thu,  5 Dec 2019 02:26:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5589BC1DD6;
	Thu,  5 Dec 2019 02:26:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA268C077D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D3F5024C4F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3pCP-yUrV+rC for <iommu@lists.linux-foundation.org>;
 Thu,  5 Dec 2019 02:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id A503F235A6
 for <iommu@lists.linux-foundation.org>; Thu,  5 Dec 2019 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575512757;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wCmR3WTSW+JcqpMr+kWdB4yDIQFlg59qjwAMgEcRII8=;
 b=JJGnPO6XVw4FRVq4RALHWf7ZyoKeV7EZt7rH+24OoUJ10dYtmIdRjoInVIB39TPokmsyLI
 UefejQ4UjFN5BxuCFaPxG2jbPZKFIASXRVRMb0fGKdjIkHL6cs9CixJNnQzN/aB4bHlzLF
 Kk7ho0dnwrJ7CC+Yp7IhXYrrjtttSrc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-O0HgSVnHNIaBRF4qmn_QPQ-1; Wed, 04 Dec 2019 21:25:55 -0500
Received: by mail-ot1-f69.google.com with SMTP id b110so1053802otc.15
 for <iommu@lists.linux-foundation.org>; Wed, 04 Dec 2019 18:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=zcDYGfqnNHA48kpKqvw0GuHAk+ixTb8IcXYC0IObKJQ=;
 b=djCjSEHBlJMr2o4icTGxn5m1cXCuBr0RBZpVd2qe3l63jp3Dzr3rLND4G8DiGL5aey
 CRMZQGTFczZvUxXY463Ii38YpHlAQGDvUrcQcFydbwLWkEFlV1H0rjY4VqouWL8c6kru
 9hdqiQJ+JoSDPJewUTkOTYKqWSxYNdYsm7SYM194nGwFKOatKWUfBaVD8JVHizcQ73Ks
 jSsMcn6IL/wf5DejED3DuOLj6E6mkUiSLx6nl9IusKrMRNn/C+uUXvAnuzuvp2Okogr8
 dAtd6k5nZIY+Zf7i97mvoRbAB0tAQ90SJtPokzvc77f0TscOlyGd4T/JH9esNxtDqBNN
 25SA==
X-Gm-Message-State: APjAAAVzWB8tATALX+arcicgLyGuGTMPhp9qrRUuzYLoPU3Wo4mBZuC1
 3DlY/LBW0ccSVV+aYd51tvwVQt6GkHQ7nrDIhPXY5YvwU0B0UWlIHhuxVvIgYr/VoYFYnA1sE4n
 LM46pP+Suj5oMp3i1SZsYKIBklDlhJQ==
X-Received: by 2002:a54:4807:: with SMTP id j7mr5524050oij.179.1575512754588; 
 Wed, 04 Dec 2019 18:25:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyj1WF09uWLvmNSDKQrn1D+0YHMtC7WBIbggPsq775+axiq/Q6HkM8A9QGZHVwDU9oAX53V1g==
X-Received: by 2002:a54:4807:: with SMTP id j7mr5524031oij.179.1575512754266; 
 Wed, 04 Dec 2019 18:25:54 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id b3sm3018748oie.25.2019.12.04.18.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 18:25:53 -0800 (PST)
Date: Wed, 4 Dec 2019 19:25:51 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191205022551.janpwjvr4kei5r7c@cantor>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
 <20191202071406.jpq5qobbtnwhktlc@cantor>
 <20191202161332.ctc3y5cvdgqwnz7l@cantor>
 <14bbe41c-61e9-d2b6-31cb-67c0b1ad11da@linux.intel.com>
 <20191203095636.epmuinnrpykecfda@cantor>
 <5ce8d57e-25f0-5d28-7408-92c650ba54aa@linux.intel.com>
 <20191204205300.4jiexjqfpnqlcagu@cantor>
 <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
X-MC-Unique: O0HgSVnHNIaBRF4qmn_QPQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu Dec 05 19, Lu Baolu wrote:
>Hi,
>
>On 12/5/19 4:53 AM, Jerry Snitselaar wrote:
>>Attaching console output (can't get to a point to actually log in) and
>>config that is used to build that kernel.
>
>[...]
>[   21.969477] pci 0000:00:00.0: Adding to iommu group 0
>[   21.971390] pci 0000:00:01.0: Adding to iommu group 1
>[   21.973173] pci 0000:00:01.1: Adding to iommu group 2
>[   21.974930] pci 0000:00:02.0: Adding to iommu group 3
>[   21.976672] pci 0000:00:02.1: Adding to iommu group 4
>[   21.978446] pci 0000:00:02.2: Adding to iommu group 5
>[   21.980224] pci 0000:00:02.3: Adding to iommu group 6
>[   21.982096] pci 0000:00:03.0: Adding to iommu group 7
>[   21.983868] pci 0000:00:03.1: Adding to iommu group 8
>[   21.985644] pci 0000:00:03.2: Adding to iommu group 9
>[   21.987484] pci 0000:00:03.3: Adding to iommu group 10
>[   21.989830] pci 0000:00:04.0: Adding to iommu group 11
>[   21.991738] pci 0000:00:04.1: Adding to iommu group 11
>[   21.993557] pci 0000:00:04.2: Adding to iommu group 11
>[   21.995360] pci 0000:00:04.3: Adding to iommu group 11
>[   21.997145] pci 0000:00:04.4: Adding to iommu group 11
>[   21.998915] pci 0000:00:04.5: Adding to iommu group 11
>[   22.000694] pci 0000:00:04.6: Adding to iommu group 11
>[   22.002569] pci 0000:00:04.7: Adding to iommu group 11
>[   22.004556] pci 0000:00:05.0: Adding to iommu group 12
>[   22.006388] pci 0000:00:05.2: Adding to iommu group 12
>[   22.008186] pci 0000:00:05.4: Adding to iommu group 12
>[   22.009968] pci 0000:00:11.0: Adding to iommu group 13
>[   22.011815] pci 0000:00:1a.0: Adding to iommu group 14
>[   22.013605] pci 0000:00:1c.0: Adding to iommu group 15
>[   22.015408] pci 0000:00:1c.7: Adding to iommu group 16
>[   22.017216] pci 0000:00:1d.0: Adding to iommu group 17
>[   22.018991] pci 0000:00:1e.0: Adding to iommu group 18
>[   22.021826] pci 0000:00:1e.0: Using iommu dma mapping
>[   22.023783] pci 0000:00:1f.0: Adding to iommu group 19
>[   22.025667] pci 0000:00:1f.2: Adding to iommu group 19
>[   22.346001] pci 0000:03:00.0: Adding to iommu group 20
>[   22.348727] pci 0000:03:00.0: Using iommu dma mapping
>[   22.350644] pci 0000:03:00.1: Adding to iommu group 20
>[   22.352833] pci 0000:03:00.2: Adding to iommu group 20
>[...]
>
>It seems that iommu pci bus probe didn't enumerate device [01:00.2] and
>[02:00.0], the corresponding context entries were not setup. Hence dma
>fault generated when devices access the memory.
>
>Do these two devices show in "lspci" output? How do these devices get
>enumerated by the system?
>
>Best regards,
>baolu
>

They are there in the output, but it seems out of order:

[   22.025667] pci 0000:00:1f.2: Adding to iommu group 19
[   22.028569] pci 0000:00:1f.2: DMAR: Setting identity map- 0xe8fff]
[   22.331183] pci 0000:00:1f.2: DMAR: Setting identity map [0xf4000 - 0xf4fff]
[   22.333546] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6e000 - 0xbdf6efff]
[   22.336099] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   22.338604] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf7f000 - 0xbdf82fff]
[   22.341189] pci 0000:00:1f.2: DMAR: Setting identity map [0xbdf83000 - 0xbdf84fff]
[   22.343700] pci 0000:00:1f.2: DMAR: Device uses a private dma domain.
[   22.346001] pci 0000:03:00.0: Adding to iommu group 20
[   22.348727] pci 0000:03:00.0: Using iommu dma mapping
[   22.350644] pci 0000:03:00.1: Adding to iommu group 20
[   22.352833] pci 0000:03:00.2: Adding to iommu group 20
[   22.354619] pci 0000:03:00.3: Adding to iommu group 20

>> [   22.356423] pci 0000:02:00.0: Adding to iommu group 21
>> [   22.358999] pci 0000:02:00.0: Using iommu dma mapping

[   22.360785] pci 0000:04:00.0: Adding to iommu group 22
[   22.362623] pci 0000:05:02.0: Adding to iommu group 23
[   22.364412] pci 0000:05:04.0: Adding to iommu group 24
[   22.366172] pci 0000:06:00.0: Adding to iommu group 23
[   22.368762] pci 0000:06:00.0: DMAR: Setting identity map [0xe8000 - 0xe8fff]
[   22.371290] pci 0000:06:00.0: DMAR: Setting identity map [0xf4000 - 0xf4fff]
[   22.373646] pci 0000:06:00.0: DMAR: Setting ide000 - 0xbdf6efff]
[   22.876042] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   22.878572] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf7f000 - 0xbdf82fff]
[   22.881167] pci 0000:06:00.0: DMAR: Setting identity map [0xbdf83000 - 0xbdf84fff]
[   22.883729] pci 0000:06:00.0: DMAR: Device uses a private dma domain.
[   22.885899] pci 0000:06:00.1: Adding to iommu group 23
[   22.888675] pci 0000:06:00.1: DMAR: Setting identity map [0xe8000 - 0xe8fff]
[   22.891216] pci 0000:06:00.1: DMAR: Setting identity map [0xf4000 - 0xf4fff]
[   22.893576] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6e000 - 0xbdf6efff]
[   22.896119] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   22.898620] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf7f000 - 0xbdf82fff]
[   22.901232] pci 0000:06:00.1: DMAR: Setting identity map [0xbdf83000 - 0xbdf84fff]
[   22.903736] pci 0000:06:00.1: DMAR: Device uses a private dma domain.
[   22.905906] pci 0000:07:00.0: Adding to iommu group 24
[   22.908705] pci 0000:07:00.0: DMAR: Setting identity map [0xe8000 - 0xe8fff]
[   22.911149] pci 0000:07:00.0: DMAR: Setting identity map [0xf4000 - 0xf4fff]
[   22.913483] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf6e000 - 0xbdf6efff]
[   22.9100.0: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   23.418361] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf7f000 - 0xbdf82fff]
[   23.420922] pci 0000:07:00.0: DMAR: Setting identity map [0xbdf83000 - 0xbdf84fff]
[   23.423506] pci 0000:07:00.0: DMAR: Device uses a private dma domain.
[   23.425680] pci 0000:07:00.1: Adding to iommu group 24
[   23.428513] pci 0000:07:00.1: DMAR: Setting identity map [0xe8000 - 0xe8fff]
[   23.430910] pci 0000:07:00.1: DMAR: Setting identity map [0xf4000 - 0xf4fff]
[   23.433253] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6e000 - 0xbdf6efff]
[   23.435794] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf6f000 - 0xbdf7efff]
[   23.438329] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf7f000 - 0xbdf82fff]
[   23.440806] pci 0000:07:00.1: DMAR: Setting identity map [0xbdf83000 - 0xbdf84fff]
[   23.443733] pci 0000:07:00.1: DMAR: Device uses a private dma domain.
[   23.446201] pci 0000:01:00.0: Adding to iommu group 25
[   23.448949] pci 0000:01:00.0: Using iommu dma mapping
[   23.450807] pci 0000:01:00.1: Adding to iommu group 25
[   23.452666] pci 0000:01:00.1: DMAR: Device uses a private identity domain.

>> [   23.455063] pci 0000:01:00.2: Adding to iommu group 25

[   23.456881] pci 0000:01:00.4: Adding to iommu group 25
[   23.458693] pci 0000:01:00.4: DMAR: Device uses a private identity domain.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
