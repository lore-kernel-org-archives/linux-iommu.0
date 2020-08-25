Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E63C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:21:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4842068F
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaGf7SUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4842068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5FC5E2155E;
	Tue, 25 Aug 2020 10:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9cE13KBxcUSR; Tue, 25 Aug 2020 10:21:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BBAC1204B3;
	Tue, 25 Aug 2020 10:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3117C088B;
	Tue, 25 Aug 2020 10:21:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98BDCC016F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 942C4860FB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YokyOaAteouW for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 10:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C2ADF860CD
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:21:06 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id bs17so10742706edb.1
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LjRa4FQ6fIW8k3lExhbXpv5P4bFiw7U6KH50o8/5jhw=;
 b=qaGf7SUMf6jQPM2DzTed4vDnvHWuC2vRK/dPvwea/rHQbUw77IgDCVbAM8229duO92
 7kAOTXB+zSY1Q5XNRGFwDo22uoTtTYu2rkrcNbWWhk0DPKGZ69s9bGduEvj1ZBkfsFl3
 VdugzHIbNr0FBZt+8e45XJkowlpakZNt6/+Ll4XdrQ94Ozn2E++xfsKy6Ex62Vm0dCgI
 zNEZFlQbjLs8y8QD+qyJEHyscypVntkw5ILvi1n8g9wFAnIHGy1XDxhz2T7+e+DaknMC
 A1wKh0oPuLqLzoHwRoZrZijBqlG3RzRclnd7B2GJl5G8nvcpnehxLUKu/ce2+KTbMfWh
 OgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LjRa4FQ6fIW8k3lExhbXpv5P4bFiw7U6KH50o8/5jhw=;
 b=ELk1T/WsDtcBsXMqF0LoZNl/hkt5yfqEb3jag/qQcohxkHemE+zOlqTRg8W16HBKII
 LHU52f2WtJfsDcUHRt5Ggp6cEElSvlrTfLRLG8VL4zfQMB8b+PRNoPgigWCbH7kVoFqY
 j1oidcCwI7HlE1hBANvRV9Dzk4jZVMHszUgbLj7FAXH/bOFlz4/E1WOww6Itf+Bm+kg8
 QtztOEi1+Q9gWUprkHdOmwpCUHQswnZJ3Vh649bG0nwEitunUWez1j5Q3PJX2YicCqby
 jPZEvla03sfL2PjkN/u3SvIsK+/cyE7f4zeSPDf2mVjI/3zFDhRmSbmpXKn9bnUgFCiT
 Q8bA==
X-Gm-Message-State: AOAM5328KPgpfxFQ/rN/XuMZfcaaS1yY3Fv9gPFrn3xguaUG2uQZ3QZO
 3AqtQHHkFliB1rtbOb4hYHsa4A==
X-Google-Smtp-Source: ABdhPJyiGqORFfeKlP8JY29iWKw1QT/obxeeskT93nDSsopvatJzI1jtO/7wBK3j51lLq2puLQOdoQ==
X-Received: by 2002:a05:6402:b32:: with SMTP id
 bo18mr9521784edb.201.1598350865212; 
 Tue, 25 Aug 2020 03:21:05 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id t22sm9816317edr.66.2020.08.25.03.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 03:21:04 -0700 (PDT)
Date: Tue, 25 Aug 2020 12:20:48 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Message-ID: <20200825102048.GB3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <31af38ba-5cda-5d60-237e-f98cfc87da1b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <31af38ba-5cda-5d60-237e-f98cfc87da1b@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

On Mon, Aug 24, 2020 at 10:26:55AM +0800, Lu Baolu wrote:
> Hi Jacob,
> 
> On 8/22/20 12:35 PM, Jacob Pan wrote:
> > There can be multiple users of an IOASID, each user could have hardware
> > contexts associated with the IOASID. In order to align lifecycles,
> > reference counting is introduced in this patch. It is expected that when
> > an IOASID is being freed, each user will drop a reference only after its
> > context is cleared.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
[...]
> > +/**
> >    * ioasid_find - Find IOASID data
> >    * @set: the IOASID set
> >    * @ioasid: the IOASID to find
> 
> Do you need to increase the refcount of the found ioasid and ask the
> caller to drop it after use? Otherwise, the ioasid might be freed
> elsewhere.

ioasid_find() takes a getter function as parameter, which ensures that the
returned data is valid. It fetches the IOASID data under rcu_read_lock()
and calls the getter on the private data (for example mmget_not_zero() for
bare-metal SVA). Given that, I don't think returning with a reference to
the IOASID is necessary. The IOASID may be freed once ioasid_find()
returns but not the returned data.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
