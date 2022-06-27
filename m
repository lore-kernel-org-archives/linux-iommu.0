Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AC0C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 08:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27B154190B;
	Mon, 27 Jun 2022 08:10:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27B154190B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=K613IOti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id axT9w6jjeZJ8; Mon, 27 Jun 2022 08:10:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B1D7415BA;
	Mon, 27 Jun 2022 08:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B1D7415BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E28D8C0032;
	Mon, 27 Jun 2022 08:10:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BBB7C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45685415D2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:10:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45685415D2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2aGVkfn6UUGw for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 08:10:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A2864109E
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A2864109E
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 08:10:07 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id d17so8251141pfq.9
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 01:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=Kp9FmTyX7dGRB9FFbW8qRxYhCrBAW1WHUiTJLo4/9H4=;
 b=K613IOtiRm08GX4X7oLeBesl1pBHqqYHcDPxV7/3JEOF5n76WCWDPXYNIgN0NseE0r
 8bhO3DE3uflpJFhEfLuanvcY7ac1lLtGB/8aZNJ1w8d3jV6V1SXnxHfkCRZIkH+m60fi
 ilVcVdkV5hD1+m3AzPdKtBDW9iqf+vzUo0E9kO/Oxbv+90q0xA8uOJhRB2Gz3SW5oEWi
 yKk2yydgdryqRmqfaDuIl43PVHCXytxBCYpQ5I2V4y5AEhtLIR3BDFYDUcWk3s24zyZI
 ERJQUFowl0fWdYSG/t8vSvdCVgNdMU6LggXDVdbEtT+SZx0p1RxJ0xGekYMy+MddZSUr
 wYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=Kp9FmTyX7dGRB9FFbW8qRxYhCrBAW1WHUiTJLo4/9H4=;
 b=4kY6bFBw7KXZGrJ8flDFykcs0lk48gt73trFi9MUJ8sPnQVmc0EQCh0zzCac3wKCUB
 RVF788YEABtFk2V6+IYZhpPmXsazHVFyCLbohGw4wBYlcrxlF3yF18V1KZJOeTzNUlUx
 rnWcNNR3JXdedeFWPZE8RIRbD6neNF++/AJ8WbkzlVEV6ZvfyuqSmHj/B/8RCKOhfPQQ
 WKe+mL/KZFwPqxiJJmfPwQPQO+xDGGa/tfElu0EM++n7LBI7U7tKv7QaoHYkTkTJcKb5
 6ELWi61MJXGzzCdbjgz8YaEiXiM/Aau5ygkTHTWEpME8DlXS1hNx4jRuTfis96TQla6H
 Pz6w==
X-Gm-Message-State: AJIora+I1+tno2O8e8agULkdjdwIDB9Ishfd6CCCPxLeXZj9w6L+j+eo
 bECBItOywdU3wLR3f7n1sN8=
X-Google-Smtp-Source: AGRyM1sg7iF/y7vKHgXwujHvRSIecgmir4U7fRrNlW+Dv0GKekuR9SBw+l3PLY+27c36Xro7hy0FTA==
X-Received: by 2002:a63:794e:0:b0:40d:99b:bb4 with SMTP id
 u75-20020a63794e000000b0040d099b0bb4mr11868551pgc.133.1656317407267; 
 Mon, 27 Jun 2022 01:10:07 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
 by smtp.gmail.com with ESMTPSA id
 y3-20020a17090ad70300b001ecdd9507b9sm6536341pju.26.2022.06.27.01.09.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jun 2022 01:10:06 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To: Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
 <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
 <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1fa7f932-ed3d-974c-dccb-de628191993d@gmail.com>
Date: Mon, 27 Jun 2022 20:09:46 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Arnd,

Am 26.06.2022 um 20:36 schrieb Arnd Bergmann:
>> There are no platform specific header files other than asm/amigahw.h and
>> asm/mvme147hw.h, currently only holding register address definitions.
>> Would it be OK to add m68k_virt_to_bus() in there if it can't remain in
>> asm/virtconvert.h, Geert?
>
> In that case, I would just leave it under the current name and not change
> m68k at all. I don't like the m68k_virt_to_bus() name because there is
> not anything CPU specific in what it does, and keeping it in a common
> header does nothing to prevent it from being used on other platforms
> either.

Fair enough.

>>>> 32bit powerpc is a different matter though.
>>>
>>> It's similar, but unrelated. The two apple ethernet drivers
>>> (bmac and mace) can again either get changed to use the
>>> dma-mapping interfaces, or get a custom pmac_virt_to_bus()/
>>> pmac_bus_to_virt() helper.
>>
>> Hmmm - I see Finn had done the DMA API conversion on macmace.c which
>> might give some hints on what to do about mace.c ... no idea about
>> bmac.c though. And again, haven't got hardware to test, so custom
>> helpers is it, then.
>
> Ok.

Again, no platform specific headers to shift renamed helpers to, so may 
as well keep this as-is.

Cheers,

	Michael


>
>           Arnd
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
