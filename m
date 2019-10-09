Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B1ECE58C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 23:50:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A93C206BB
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 23:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3G816pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0509CDF2;
	Wed,  9 Oct 2019 23:50:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DCE05DE1
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 23:50:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [205.139.110.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 354AC14D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1570665015;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=YAtqhT5ONsjqWUWONs3upOQbCcX6WU5MkOT7sl7Bewo=;
	b=I3G816pIrs5JzNswH8L+jg79EoPY0ZBz4gJVEMxnRSCdz/uvZh9bwsSGYPFqBA1tYXdlEz
	Gp+8G3K47wZHXAo9D8Poj8yTZMaO5lvilRgpdwYs16iXQRrCyX5uEILYoJSC7D+kVgzubP
	88tSYzqOeI+s3FtBBYZcMe1lK9iMBB8=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
	[209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-330-qE0yQ3vSMGymWSvFfWuSzA-1; Wed, 09 Oct 2019 19:50:14 -0400
Received: by mail-io1-f70.google.com with SMTP id k14so6765930iot.14
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 16:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:mail-followup-to:references:mime-version:content-disposition
	:in-reply-to:user-agent;
	bh=focIOQfcQNyrOXPkI531vbndDZb3WURIChJxW2xJzLs=;
	b=hgpQkVCH3znyk9OcMQgwE+ydK4rVs2fs6+5jrPATJKMz+ir5xyfkI+MwWX6Jp2TbBN
	NmeMyTip7dxVq5s9IIbrOBBCwAsAUpzw76raeyJGvXNAHYu1DYVHwie+Vkr2m19WODIE
	geAfN/W4MORW6CKy2kS8rSh0WP8I7l0vEQsln+DJN8K0IMOe6FzyuMJH43308NMwYqXu
	mkKRF8lQyo3OKdZnXuB/mvoxH2NRfxP5xZsFPT6RqtXJqg5KFwp8f7u93/5L/gqO3jdS
	/WNlO0anrgZofraz+RKmOradH5mSo5VIyDI7pYAnlAQc58hy1NJsCPNbI/9GtbRWl5yH
	pxXg==
X-Gm-Message-State: APjAAAXn7fHbIhBZD9Dlt7COlmU9FA6Ae3piKfvhPHJap8RymLbT2oSU
	h4FHDtYkXJYHyuyAU+WljT1StE/bMfJweeI+WN2jmU3+Ta7K1a1az3ygw3Ms6h2HrTpD0ZmzmBM
	yhxoaeJVQJ89eX30OcSypMIf2HDGYSQ==
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491128iot.209.1570665013831; 
	Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyBHaFMxZO0WJshtgxh7/OOthnkRt0Ri0Ng2qxBJgBmVLrUfw4ehvtKeNCwBnq7zLTnWQxQQg==
X-Received: by 2002:a5d:8b49:: with SMTP id c9mr4491111iot.209.1570665013586; 
	Wed, 09 Oct 2019 16:50:13 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id
	f23sm2553411ioc.36.2019.10.09.16.50.12
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 09 Oct 2019 16:50:12 -0700 (PDT)
Date: Wed, 9 Oct 2019 16:50:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/2] iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
Message-ID: <20191009235009.a3mxw4qrklkqwuzf@cantor>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: qE0yQ3vSMGymWSvFfWuSzA-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Oct 09 19, Bjorn Helgaas wrote:
>From: Bjorn Helgaas <bhelgaas@google.com>
>
>I think intel-iommu.c depends on CONFIG_AMD_IOMMU in an undesirable way:
>
>When CONFIG_INTEL_IOMMU_SVM=y, iommu_enable_dev_iotlb() calls PRI
>interfaces (pci_reset_pri() and pci_enable_pri()), but those are only
>implemented when CONFIG_PCI_PRI is enabled.  If CONFIG_PCI_PRI is not
>enabled, there are stubs that just return failure.
>
>The INTEL_IOMMU_SVM Kconfig does nothing with PCI_PRI, but AMD_IOMMU
>selects PCI_PRI.  So if AMD_IOMMU is enabled, intel-iommu.c gets the full
>PRI interfaces.  If AMD_IOMMU is not enabled, it gets the PRI stubs.
>
>This seems wrong.  The first patch here makes INTEL_IOMMU_SVM select
>PCI_PRI so intel-iommu.c always gets the full PRI interfaces.
>
>The second patch moves pci_prg_resp_pasid_required(), which simply returns
>a bit from the PCI capability, from #ifdef CONFIG_PCI_PASID to #ifdef
>CONFIG_PCI_PRI.  This is related because INTEL_IOMMU_SVM already *does*
>select PCI_PASID, so it previously always got pci_prg_resp_pasid_required()
>even though it got stubs for other PRI things.
>
>Since these are related and I have several follow-on ATS-related patches in
>the queue, I'd like to take these both via the PCI tree.
>
>Bjorn Helgaas (2):
>  iommu/vt-d: Select PCI_PRI for INTEL_IOMMU_SVM
>  PCI/ATS: Move pci_prg_resp_pasid_required() to CONFIG_PCI_PRI
>
> drivers/iommu/Kconfig   |  1 +
> drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
> include/linux/pci-ats.h | 11 ++++-----
> 3 files changed, 31 insertions(+), 36 deletions(-)
>
>-- 
>2.23.0.581.g78d2f28ef7-goog
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
