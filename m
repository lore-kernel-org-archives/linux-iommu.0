Return-Path: <SRS0=TVo/=HV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFFC433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 17:36:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6C764E86
	for <iommu@archiver.kernel.org>; Fri, 19 Feb 2021 17:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6C764E86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 457AA86B83;
	Fri, 19 Feb 2021 17:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVVn4bO7YRwn; Fri, 19 Feb 2021 17:36:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C1BB98643D;
	Fri, 19 Feb 2021 17:36:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6362C000F;
	Fri, 19 Feb 2021 17:36:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D875C000D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 518A786A70
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXTSALYjLhM1 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 17:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5ADEA8643D
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613756162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abNqZIPf4yq/Gg29GOX0Pz9qXxE9hVUthAlUC+bEOoE=;
 b=S7P+22h/F3B6OC+x3scvFM4m3Lhgn6bkZ27q0w8fwGNZUhXDLIUpF49ghS3sBE21wwZC6X
 +DL4s4LU5xAomas8giSfhxdqmTFUtJDzjhrJRuKQJrH1L8dWmJdLFTff/D0M90JFgDYJew
 Yx4qUKN72Qa1WVpjLbCyFhxh5qkpgA4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-jKlj7bCRO0yw_M2mNEA38w-1; Fri, 19 Feb 2021 12:35:59 -0500
X-MC-Unique: jKlj7bCRO0yw_M2mNEA38w-1
Received: by mail-io1-f69.google.com with SMTP id k21so4030670iow.6
 for <iommu@lists.linux-foundation.org>; Fri, 19 Feb 2021 09:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=abNqZIPf4yq/Gg29GOX0Pz9qXxE9hVUthAlUC+bEOoE=;
 b=mxorQlVeM2m0L9EwRrd/+E2ONWiV++4/wru5C4rWLt4WHz3PfECR3a2TFnEltMouA+
 Jdz/0xfF90P8CerPKrxzpIfqi4zhhYkWF3nk5FQQ3JVQtzVttDKBkR/n9D350nRyRENB
 GA5vckdqZjNYGXNYsV/IBM+6mzZXjD5WpNgnUB2D+Ljff2TUoyoNXdHBFFqmtmFnrWNZ
 ZEaAy04fNM8nTLpRDEKs0DKfeRsK4H7sQsb8wQs6LAjG9azbfVHoaVZOSlgGDc0xQV9Q
 qDN+B21IznUl2K2i3QLmkeh/KvBQnfS92AdALV+YTtQC5D9KvNmLj+jZ0uTJfME5x6zm
 E5mA==
X-Gm-Message-State: AOAM533oHIGkb2YvQRpA/JQfptq/mdHzeuowrX2QUs8fAtC1YTQyRIjg
 RV7ql4ZIHsKHkynsQWdYhPjE9yfpyYJ+dednZJE9EHXMwpPxf2MF4ZxrmmS2SAAZNz1P6nXyEAP
 2PFXu/ZqmPhSpnvHxAmT3Ym6LkEkrlQ==
X-Received: by 2002:a92:d44b:: with SMTP id r11mr4816021ilm.159.1613756158849; 
 Fri, 19 Feb 2021 09:35:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw84o/TRoiBaKhLvjtDK+OD5pZIrO5g5USr1lUji2GfvmFqN+An1eWZnFmkFYtW9gM5QPo2Sg==
X-Received: by 2002:a92:d44b:: with SMTP id r11mr4816010ilm.159.1613756158676; 
 Fri, 19 Feb 2021 09:35:58 -0800 (PST)
Received: from localhost (71-218-248-79.hlrn.qwest.net. [71.218.248.79])
 by smtp.gmail.com with ESMTPSA id r21sm8260771ioa.24.2021.02.19.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 09:35:58 -0800 (PST)
Date: Fri, 19 Feb 2021 10:35:57 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20210219173557.GL702808@redhat.com>
References: <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
 <20210202202713.GF702808@redhat.com> <YBpjAF3Q+NeJblE9@myrica>
 <20210204202524.GO702808@redhat.com>
 <20210216213103.GT702808@redhat.com> <YCzj85YDWRxmrCHo@myrica>
 <20210218233943.GH702808@redhat.com> <YC+f5bTMLFYgiOvS@myrica>
MIME-Version: 1.0
In-Reply-To: <YC+f5bTMLFYgiOvS@myrica>
User-Agent: Mutt/1.14.6 (2020-07-11)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ahs3@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 Yinghan Yang <Yinghan.Yang@microsoft.com>
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

On 19 Feb 2021 12:24, Jean-Philippe Brucker wrote:
> On Thu, Feb 18, 2021 at 04:39:43PM -0700, Al Stone wrote:
> > As of today, the proposal has been approved for inclusion in the next
> > release of the ACPI spec (whatever version gets released post the 6.4
> > version that just came out).
> > 
> > Congratulations ?!? :)
> > 
> > And thanks to all for their patience during this process.  You now
> > have the dubious disctinction of being the very first table added
> > to the spec that _started_ as open source.
> 
> That is great news! Thanks again for your help with this :)
> 
> Just to confirm, we don't need to wait for the release of the 6.5 version
> of the spec before upstreaming support for the table?

Correct.  This is why the UEFI community-first process exists -- so
the work can be done in the open instead of having to wait for the
next spec release.

> Another question that might come up at some point, is how to add new
> subtables. Is the process documented somewhere?

We would do essentially the same thing: there would be a discussion
on a list somewhere, a conclusion would be drawn, and an ECR put
together to send to the ASWG group (any UEFI member can do that, like
Yinghan, for example).  All discussion of changes would occur in the
open -- ASWG is really just monitoring progress in these cases.  Once
it is clear that the proposed change is stable and essentially
finalized by the community, there would be a final vote in the ASWG
on whether to include it or not.

> For the moment I sent a -poorly numbered- pull request for acpica:
> https://github.com/acpica/acpica/pull/666

That's hilarious :-D.  I'm sure it will be just fine :-)....

I'll put a tag on that PR to track it.

> Thanks,
> Jean
> 

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
