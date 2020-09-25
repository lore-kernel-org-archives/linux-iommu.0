Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEDCC4741F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 11:26:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFA623718
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftqCBkfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFA623718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4EE286CB3;
	Fri, 25 Sep 2020 11:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gry5JB79nlfF; Fri, 25 Sep 2020 11:26:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D69986C73;
	Fri, 25 Sep 2020 11:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C3D4C0859;
	Fri, 25 Sep 2020 11:26:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16FB2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 019AF86C94
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6uY6kyRmr5Q6 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 11:26:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 095C986C73
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 11:26:50 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y15so2904369wmi.0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=A60QA7/hIdfukqiV/j0jVbWiv3LMArbDpJyApzX3WvI=;
 b=ftqCBkfn/C4p7By9V/KyZFqPJeZy7/xn1PfcJxEBZdug495AZSrw033D60K7eAB6Ig
 T98+fFtAtR2fMfrf4YpUyoeQAItmIPpMlw70708iaz4Mys8RWfY2L98A6R2XRNA82dEr
 a08VdMoZwpfa9+SIFcuqZyeGWLJU3y8eSbJDwTprwOVIB1VgWpnJf2RaAPIGgXd8cIrK
 Pu0SWfemDZSdI8Ed0fXEr6cbjjHFarJER4aRSRYls0ebusVExXYK1NbWWwqy1Il2FhLO
 qOa+1Tog0CADvniUdEJMYfA7Bsk0DoYsFbpV1Pp5Khcuf7QbdoWqeYDorAGSyVqjNm+y
 zsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A60QA7/hIdfukqiV/j0jVbWiv3LMArbDpJyApzX3WvI=;
 b=UkZ2rTiIo0IUBclbvbJSsHYX9T2nZzl93L/G8tCM7mvLtM/14g4qdMZHJUn+++SLBI
 HxBE4/yBqe9uP4hnWmV5itTCcj/BYIVhFGQLWAebWECev32lYjcxm1O3ZM0jf6DfligR
 WDIVvnfc4o0N/PGag1etFwhU5+BkRyg5IHV0UIFl4Y4DK98yao9U1Flh+DzJzjdFqvEA
 xJJvZxkItb6FK6V1bNjmeUVXQB4+HnyGC7tloTm5MgKywfjvpvF0yhLbZQpsfDxJjWNM
 VQp+BklHQAbA57CloSpGGWMuD+7s9yr+5IeEeyxevTy+hRsCsj5cj3cDB0u9xXOb50+M
 ezXg==
X-Gm-Message-State: AOAM530RffBH+U2Fc9GQF5X1FPpb5TzpHR+mqAvUgIAEhbXASw0ICs7x
 LRtTzKrHDEaa9zWMS3e4WpEvug==
X-Google-Smtp-Source: ABdhPJyv13qwG5g2DgIM8ecyiaNCHrI1193NKi2NMlWF2QntaY8OnbgiSNf16JhwZ6M3gzNUrPJS7g==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr2764224wmi.53.1601033208483; 
 Fri, 25 Sep 2020 04:26:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w7sm2422588wmc.43.2020.09.25.04.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 04:26:47 -0700 (PDT)
Date: Fri, 25 Sep 2020 13:26:29 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925112629.GA1337555@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200925084806.GB490533@myrica>
 <20200925062230-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200925062230-mutt-send-email-mst@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 bhelgaas@google.com, jasowang@redhat.com
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

On Fri, Sep 25, 2020 at 06:22:57AM -0400, Michael S. Tsirkin wrote:
> On Fri, Sep 25, 2020 at 10:48:06AM +0200, Jean-Philippe Brucker wrote:
> > On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > > Add a topology description to the virtio-iommu driver and enable x86
> > > platforms.
> > > 
> > > Since [v2] we have made some progress on adding ACPI support for
> > > virtio-iommu, which is the preferred boot method on x86. It will be a
> > > new vendor-agnostic table describing para-virtual topologies in a
> > > minimal format. However some platforms don't use either ACPI or DT for
> > > booting (for example microvm), and will need the alternative topology
> > > description method proposed here. In addition, since the process to get
> > > a new ACPI table will take a long time, this provides a boot method even
> > > to ACPI-based platforms, if only temporarily for testing and
> > > development.
> > > 
> > > v3:
> > > * Add patch 1 that moves virtio-iommu to a subfolder.
> > > * Split the rest:
> > >   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
> > >     support.
> > >   * Patch 4 adds definitions.
> > >   * Patch 5 adds parser in topology.c.
> > > * Address other comments.
> > > 
> > > Linux and QEMU patches available at:
> > > https://jpbrucker.net/git/linux virtio-iommu/devel
> > > https://jpbrucker.net/git/qemu virtio-iommu/devel
> > 
> > I'm parking this work again, until we make progress on the ACPI table, or
> > until a platform without ACPI and DT needs it. Until then, I've pushed v4
> > to my virtio-iommu/topo branch and will keep it rebased on master.
> > 
> > Thanks,
> > Jean
> 
> I think you guys need to work on virtio spec too, not too much left to
> do there ...

I know it's ready and I'd really like to move on with this, but I'd rather
not commit it to the spec until we know it's going to be used at all. As
Gerd pointed out the one example we had, microvm, now supports ACPI. Since
we've kicked off the ACPI work anyway it isn't clear that the built-in
topology will be useful.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
