Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770EC433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:54:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70B36127C
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C70B36127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8FF1D40586;
	Tue, 28 Sep 2021 17:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKMCTT4GyzDL; Tue, 28 Sep 2021 17:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CB2140565;
	Tue, 28 Sep 2021 17:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20602C001C;
	Tue, 28 Sep 2021 17:54:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F36F1C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D24BB60B2E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fhwCEw6aIaET for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 17:54:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 101A560777
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:54:34 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 u1-20020a17090ae00100b0019ec31d3ba2so2282397pjy.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
 b=m9sdz73zrjMRDNHc22Gye23uo5ygGPs1cs0mwoNlJ8VUnRLj8voa2vDhgXj2bS9aj2
 aFhf//KoZX796AfWAxpvTXYans8OImGiqCnRmi3Sk6Ml+QvEusKyfBHiXH1VyjA/4sAj
 UeJfSWxx/AfUAAGtCDiw7qNfVTwlszxzNkutU2boB4mHGNl+IVnbL6EhEyS0Cbiztu0L
 JVqp+cBc6JyoHQsLuIcU0LZ6aCx3k+4ofEprD7f3HduGu0V2uJP+PxCitVTzo0PLQ7RZ
 AxHnDX37k0hreucdd5P9XUEzif8rbactBU8SMjoIo1axW/j7y7ez4LhcbOiIdS/8XM3N
 3iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=orLVhujXuv2LS5anVE9u/slnGdTOgg9Wqn1uh5hqGWw=;
 b=KMszkYNsBzhjuLMjmCgOvUhWdgnRxLKWgFjKKqbVrB5yXpPSpESUTt4nIqLaQaEVUU
 zUNXNjuJXs9yYo8eJP3PZvb440uz/6mjHMZxLcnmrr2EA2YqiVTMzERJBvXr4dpEoYuR
 hv3quvHn2UrBBi4jQ6i/5OtnD2+7I/uF57Pu9SfqFJ+jAoSOFgsKf8HZsr84mZ8yJeae
 oNes9moE9kqSyOLxaMcOJMAF0xkiUpDPu29Uq1JHuIGkzN+TdFdWm+CifqKzzCRZgrw8
 hpzL0FI6NXNufxGHksMz7MgzzwsU73HRa2cnDTnI/ctU8OGhp03X0fkh7lvmKJvRd8f4
 L5Cw==
X-Gm-Message-State: AOAM531xnTqYJv6A2dGuybXeW/WGPxryn4zLQuyzwpaV08Eh85+njXla
 tVZkJQZFvlFsBclc4Xc7ayrfUC12P/38AGyu1Eq+BQ==
X-Google-Smtp-Source: ABdhPJzAafw90qw6GNR9KOTGCaZVcRyonxJQDUdkiFkRD78TDB31Hda8XvnX+oGdm1yTApwMPKKhgoUwD7Dy3t2YpxQ=
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1390645pju.8.1632851674343; 
 Tue, 28 Sep 2021 10:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-10-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-10-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Sep 2021 10:54:21 -0700
Message-ID: <CAPcyv4i4T4XLW-P=CzdO47mZ8+_Mih7GMeDEXAtgEE+gO9JQHw@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Use pci core's DVSEC functionality
To: Ben Widawsky <ben.widawsky@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Reduce maintenance burden of DVSEC query implementation by using the
> centralized PCI core implementation.
>
> Cc: iommu@lists.linux-foundation.org
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d75f59ae28e6..30c97181f0ae 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5398,20 +5398,7 @@ static int intel_iommu_disable_sva(struct device *dev)
>   */
>  static int siov_find_pci_dvsec(struct pci_dev *pdev)
>  {
> -       int pos;
> -       u16 vendor, id;
> -
> -       pos = pci_find_next_ext_capability(pdev, 0, 0x23);
> -       while (pos) {
> -               pci_read_config_word(pdev, pos + 4, &vendor);
> -               pci_read_config_word(pdev, pos + 8, &id);
> -               if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
> -                       return pos;
> -
> -               pos = pci_find_next_ext_capability(pdev, pos, 0x23);
> -       }
> -
> -       return 0;
> +       return pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_INTEL, 5);
>  }

Same comments as the CXL patch, siov_find_pci_dvsec() doesn't seem to
have a reason to exist anymore. What is 5?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
