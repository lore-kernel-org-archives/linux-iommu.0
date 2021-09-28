Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF515C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:43:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680F661357
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 680F661357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20A7A4047F;
	Tue, 28 Sep 2021 17:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J2tXUh6VrKXn; Tue, 28 Sep 2021 17:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D346E40105;
	Tue, 28 Sep 2021 17:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 961D8C0022;
	Tue, 28 Sep 2021 17:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA3CC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DC27401A2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSLyFr992eMF for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 17:43:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F1E340185
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 17:43:32 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id w14so19560621pfu.2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=imp5I7p53F2DZ1YVYnsTH+B34q59d+HgTV0CrYjuwxo=;
 b=FKSA5duzWRw87ND8p4lngfxsNUmCYFC44YeU70RM2fO3H/yHuH9M8QAsg6bBXTVGqG
 3FzsJWZner5fSvs4m//3O3KT4Er9dHUAKbxccSn9HST/Muq0BTHUTTxiAAVbsVwLn32F
 kMu5q37rLliYt0miOzAML2ekRzAjfDa2oIa9haIsSoVwsZQmx1vS1WDTYixCibF16NoD
 PysTgZlSI4xgn682PA88sYHTzF2Ripl8Xt/5ETc7WmqGsbfvX47bK9Mv0Tv6ZetpFN1f
 4iJKT3z+f1Hd5msRz+IxwpazFQn4bqCPJrKXdTaNL+9xpv6VObc7DAnRAvZcn6ijId1S
 hTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=imp5I7p53F2DZ1YVYnsTH+B34q59d+HgTV0CrYjuwxo=;
 b=BjdxEnCHSpsgTiSOauQS+gcEJGw7ThDEXcr4dgZIt2Ov86kaYg8kqS0sivN3gJL3bv
 6Z907c921rSV/Sb1XyWOWvUi3ICW5Dqc1qvWlvhFUa0KMAgLEfj7R8YYKL6aaFVNCgZL
 GKeNWNWs5YcdazhqQiMv0mHW/+eJmins9PB+lmgPE7nhwTxOkZyHWhaLB42KE0/H+j0C
 Gy9JzTgralY0gPpJ5J4bA+WXCz0mu6hHv+2UCMIWd/vWmkIqhzRqZipM0XcOWKLEAy1W
 DFqd2J2UIxrRSk9OHMd3g21dXC/4WfJq3q2TDGxJvz3rZa7boqWgdmqryrwv270dUAbl
 S2Gg==
X-Gm-Message-State: AOAM5322fecwItAqdyuypp+Yr4Ld6V0gZ63pzpwSRNuMK2pZOt+msLSf
 LLGJokxMUtumtbRcT0UpJF5g+GyUlGyIamx4VXERfw==
X-Google-Smtp-Source: ABdhPJzjFahY5zlVRdQpZP5HYQgI99KxcTCTyAuujDoILwq7WhTATCP0bUPpo4Bx1rVGm7VXzxNZyVmeIZH5CGfCiSk=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr6437884pfd.61.1632851011800; Tue, 28
 Sep 2021 10:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com>
 <20210923172647.72738-8-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-8-ben.widawsky@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 28 Sep 2021 10:43:19 -0700
Message-ID: <CAPcyv4jHnio-4vcJ5Y7yhcYKT+Gy73Rgfn5YuRn68_CKbbWnmw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] cxl/pci: Use pci core's DVSEC functionality
To: Ben Widawsky <ben.widawsky@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-cxl@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "David E. Box" <david.e.box@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Kan Liang <kan.liang@linux.intel.com>
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
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5eaf2736f779..79d4d9b16d83 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -340,25 +340,7 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, struct cxl_register_map
>
>  static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)

cxl_pci_dvsec() has no reason to exist anymore. Let's just have the
caller use pci_find_dvsec_capability() directly.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
