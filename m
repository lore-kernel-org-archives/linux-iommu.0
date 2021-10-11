Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F09C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 08:50:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4058860F35
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 08:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4058860F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EE1B60786;
	Mon, 11 Oct 2021 08:50:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ttv3W0esgXc; Mon, 11 Oct 2021 08:50:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA54760715;
	Mon, 11 Oct 2021 08:50:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF438C000F;
	Mon, 11 Oct 2021 08:50:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27EE2C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 08:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 068CD814B1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 08:50:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7EUS_EkyqaH1 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 08:50:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AA3B81045
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 08:50:22 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id t2so53661736wrb.8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sk2vwHpDMapSB20kMOT3PpeVWQ3nV2u+hdesFvlhlXY=;
 b=sQAx9Y55PmndkkUA9JgbLSEHf3wecXknr9PmN8XlAGjxLyHPxu+BHmo1eXm9nYNm8H
 EhgZTCAikbV4yKa5OEEV9/sNqub8qLpMgx07yHaMbB1MwZSFwO7vMTjTBIbYDcJRTC4D
 uHh5ZHWqw7gnMN9popQqddpv4yE+SKKA+mjSlefLb2ZOC25Agj+2S+SoJqdENxlkELTN
 js52PoywEeVWqdQz836ClJ6+Q6wdubCG8sQYQYCJYXPD80YePUXmkgJAvArP0gEQaa5o
 flZ8DHcxIkiQVesPqVbKEaWwo480lb2JwDOSVFwNfhTqQpQL6qtj+2PypAO0EtgGDBWo
 ivPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sk2vwHpDMapSB20kMOT3PpeVWQ3nV2u+hdesFvlhlXY=;
 b=4iPjwhwnHgp2q+BxtWVGjRM7mSuQBKqUmKj2VU+1ZGmeyfYHTJAo2XGjk+NOGQc/Ny
 UtTtshSUF+nDyyTXL+03SIn+NOUrbt8MEeXgb1dlyyTTazZdOBMhL/3t6pdGPe89jvRE
 yub4Xy9R3ArWi13l6ga4oS1cvv28OGCuKEUOyBmWKfHsaeiijhc6HCnsijhWbrutXvZC
 4duLQzhqhW326kC7Vf0i+Ta5Q0TmTm38mKM5LGEuhA3rvMjck1YPgAuRM0IQFdt43EEp
 7s9Plh7WlpOI0m7wqqmz/Q6QGQX0H7fHNJ9fGrV5VaFfvmfggkSixUbPLBK8S3TQDQ5p
 ThTg==
X-Gm-Message-State: AOAM533np6otM1fRK4L1TKijz2NN1RzQAmO4GQQ6ST0mmhv6LmR2uYyn
 AN46rytioAvRLFHOnyvC5gjNTQ==
X-Google-Smtp-Source: ABdhPJzU/1wA9A5uHZLtCS/EoNkG6y371Lka8wmYuBYDzHsaXCr/VdFzCzKHlkRdGz3TZTk0YVvlOQ==
X-Received: by 2002:a05:600c:2109:: with SMTP id
 u9mr13026461wml.68.1633942220114; 
 Mon, 11 Oct 2021 01:50:20 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id g188sm7226525wmg.46.2021.10.11.01.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 01:50:19 -0700 (PDT)
Date: Mon, 11 Oct 2021 09:49:57 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWP6tblC2+/2RQtN@myrica>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com> <YVanJqG2pt6g+ROL@yekko>
 <20211001122225.GK964074@nvidia.com> <YWPTWdHhoI4k0Ksc@yekko>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YWPTWdHhoI4k0Ksc@yekko>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 Jason Gunthorpe <jgg@nvidia.com>, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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

On Mon, Oct 11, 2021 at 05:02:01PM +1100, David Gibson wrote:
> qemu wants to emulate a PAPR vIOMMU, so it says (via interfaces yet to
> be determined) that it needs an IOAS where things can be mapped in the
> range 0..2GiB (for the 32-bit window) and 2^59..2^59+1TiB (for the
> 64-bit window).
> 
> Ideally the host /dev/iommu will say "ok!", since both those ranges
> are within the 0..2^60 translated range of the host IOMMU, and don't
> touch the IO hole.  When the guest calls the IO mapping hypercalls,
> qemu translates those into DMA_MAP operations, and since they're all
> within the previously verified windows, they should work fine.

Seems like we don't need the negotiation part?  The host kernel
communicates available IOVA ranges to userspace including holes (patch
17), and userspace can check that the ranges it needs are within the IOVA
space boundaries. That part is necessary for DPDK as well since it needs
to know about holes in the IOVA space where DMA wouldn't work as expected
(MSI doorbells for example). And there already is a negotiation happening,
when the host kernel rejects MAP ioctl outside the advertised area.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
