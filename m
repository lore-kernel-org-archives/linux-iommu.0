Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB0C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:11:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1174A20758
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 12:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAA3HOUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1174A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A4E18754D;
	Fri, 15 May 2020 12:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9XAi8uChdhk; Fri, 15 May 2020 12:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 65FB587B15;
	Fri, 15 May 2020 12:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE84C0178;
	Fri, 15 May 2020 12:11:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49B15C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 326388836E
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDoYTyqNYHYa for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 12:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9864B89A37
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 12:11:38 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id h17so3247786wrc.8
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=agk/UV20FKJb1a9Ae3ltu4rCzUn8RKE17XB/I2juUP4=;
 b=JAA3HOUQkZNQ5tgh0mBb8QhPLgNWLKouFcUBPxDtnimi/m5pBrCEkujCkn9WxFBeqo
 ErHwhzIj4ddXEo7xzOPe8Rc57zZOcaT94w0056MbMo41lOLkETzul319Ley474NnQh+F
 8bdvV49MZN6vQczqFvGdH1QS2jXgL+rTLszQRyjTnKs6V31vhKqdKkuosC0DpM/KeXbD
 TYl2/1AuayujwtiK321gyz6laoHA/yv7w8eYv40EaVs+H7ItH1G+InjvaGmhzUyWtZLW
 ZKd33niBQ6nWQiyCZ7sjsEnWFWlKgmv37OKJCdNGO2o16ayD0NbkG9SzJzxIXBUPVD5z
 uEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=agk/UV20FKJb1a9Ae3ltu4rCzUn8RKE17XB/I2juUP4=;
 b=qT+wd9NyB51fAg0yMMWuCG8AUMedkly0gRSthPS/HyCE2YJTQDXuKH1PqiUCCOIBe0
 GFh9RB16KnV+1rpbyCnhoC3LGo4bjU6wWMi5xyceN8weDS2bNQvt4l5/pX7zHdMmvyT/
 htTD5mSNLreHG9swQt+nq17LdB6Hea5lOA/VBGeqrxUj1ewerWMAjq1bL7P4mwG3Ftr4
 dfmRZsnc8R7cB9nr/U8pf5FKimMNfoMV/bPFdjSGQJ2WYb8SVEkmswUkHjFfHPNvIAJ0
 dySwxuMPsiOU9x+p+19T6rPVXy7Hu6sZByjVcQHqfbXfQj8UHrCsOFopvVFJRMJ10SkQ
 kdmQ==
X-Gm-Message-State: AOAM531CBGrqtM4QH0Jqfcj25D2EUI3wFBLn9te5p+5iwlRbS9l2s05t
 nzKwLwhckVmEIO6I8B/8xkxMtA==
X-Google-Smtp-Source: ABdhPJySrffUnSNQVxZ4+5EcEPpnx2BcRy+rX17KVduf39fOlhtS3S6VeNRSKTYDyFwHQHp61SI0Pg==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr3883139wrw.319.1589544695178; 
 Fri, 15 May 2020 05:11:35 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id y3sm3305545wrt.87.2020.05.15.05.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 05:11:34 -0700 (PDT)
Date: Fri, 15 May 2020 14:11:24 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Message-ID: <20200515121124.GA784024@myrica>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515104359.1178606-3-jean-philippe@linaro.org>
 <20200515120150.GU18353@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515120150.GU18353@8bytes.org>
Cc: alex.williamson@redhat.com, ashok.raj@intel.com, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, iommu@lists.linux-foundation.org, bhelgaas@google.com,
 will@kernel.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, May 15, 2020 at 02:01:50PM +0200, Joerg Roedel wrote:
> On Fri, May 15, 2020 at 12:44:00PM +0200, Jean-Philippe Brucker wrote:
> > The pci_ats_supported() function checks if a device supports ATS and is
> > allowed to use it. In addition to checking that the device has an ATS
> > capability and that the global pci=noats is not set
> > (pci_ats_disabled()), it also checks if a device is untrusted.
> 
> Hmm, but per patch 1, pci_ats_supported() does not check
> pci_ats_disabled(), or do I miss something?

The commit message isn't clear. pci_ats_init() sets dev->ats_cap only if
!pci_ats_disabled(), so checking dev->ats_cap in pci_ats_supported()
takes pci_ats_disabled() into account.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
