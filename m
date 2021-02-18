Return-Path: <SRS0=roZV=HU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C88DC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 23:39:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBBF64EBD
	for <iommu@archiver.kernel.org>; Thu, 18 Feb 2021 23:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBBF64EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4FC3386ECF;
	Thu, 18 Feb 2021 23:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S8FyYURGg+jJ; Thu, 18 Feb 2021 23:39:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 146A486DA9;
	Thu, 18 Feb 2021 23:39:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF355C000E;
	Thu, 18 Feb 2021 23:39:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0A4C000D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 23:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2F69D86DA9
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 23:39:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11hVO4tnCrcW for <iommu@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 23:39:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 32DFE86D9F
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613691586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YB4PjkAYVz0RdozZLt62j6oV56jwHjvpj07YNHkjCoQ=;
 b=JDpAdzO46YLjCxcz5Kp3SKmASjRTX+tu1IJR6aAlFGI4ri3O60ewZPSofRrduLzHcRM3bw
 KQUXYqzR1el/wL2+rKC7yHxCZK3DPWSGs1LI3HB41KW7Ji74dtkEM/+VCkdurudv3zCMYY
 qCxFbWO2Dbwxyz+u9l3ATAxFXXp5AG8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65--xmcGzSEPh2KDPbQCaGnGg-1; Thu, 18 Feb 2021 18:39:45 -0500
X-MC-Unique: -xmcGzSEPh2KDPbQCaGnGg-1
Received: by mail-il1-f198.google.com with SMTP id i7so2301980ilu.2
 for <iommu@lists.linux-foundation.org>; Thu, 18 Feb 2021 15:39:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YB4PjkAYVz0RdozZLt62j6oV56jwHjvpj07YNHkjCoQ=;
 b=bgr7J1/srX0j7ZzixuPiHMlYSi5SVyv+DTNscnNz4oQm4J37HHduwvLZiF6TZ22e+A
 MKTxhNttxhy3vSXHtbKWAbMPaHFcikPLwwQgWnE9ETlBMjWiJDeGLN5nuIA3hGqNMctG
 4Xv8w+eNFBzRSyjEBqnz/KXEUAAfQlPcLAgegU1o6GNA1TwS1naoSMq18bUJmEdGb0Zc
 TZAzVrsFLZBN8w8jsZuvOgS9box3Qo61F3w3Kz1IWFHMutY8eqBHsbFJ6F1uR9ENBWb+
 heZCerVjQZVnrW3TsX7ebzzTeMRhr3vlSOwZkI1ztE+K1kgyiorNfEX3G0l/mYC02gZx
 J3jg==
X-Gm-Message-State: AOAM532H00iAQAbaBAQU1ucCGhMQyKaRGBnv3EOhYGpZT80/OcMdAsuH
 7HqKQLzlFePhzBe4PYqbIKSHArAqnbsMT+dTlEzjaZkMRcKXAh5sTboFHWV4C4e/6ibGQZuts2X
 4Db03PWlL7f8QGzcM3LVPkerrGt4emQ==
X-Received: by 2002:a92:c269:: with SMTP id h9mr1400391ild.239.1613691584668; 
 Thu, 18 Feb 2021 15:39:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5CAIDlmc6TWgZfXksPUd9uYnguKenlvmdU7YZom/IJXEIsFeueFQ0VDQGRQHT4etoRGa6kg==
X-Received: by 2002:a92:c269:: with SMTP id h9mr1400376ild.239.1613691584455; 
 Thu, 18 Feb 2021 15:39:44 -0800 (PST)
Received: from localhost (71-218-248-79.hlrn.qwest.net. [71.218.248.79])
 by smtp.gmail.com with ESMTPSA id r9sm5881621ill.72.2021.02.18.15.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 15:39:43 -0800 (PST)
Date: Thu, 18 Feb 2021 16:39:43 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20210218233943.GH702808@redhat.com>
References: <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com> <YBkYsSHGUfG91NoN@myrica>
 <20210202202713.GF702808@redhat.com> <YBpjAF3Q+NeJblE9@myrica>
 <20210204202524.GO702808@redhat.com>
 <20210216213103.GT702808@redhat.com> <YCzj85YDWRxmrCHo@myrica>
MIME-Version: 1.0
In-Reply-To: <YCzj85YDWRxmrCHo@myrica>
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

On 17 Feb 2021 10:37, Jean-Philippe Brucker wrote:
> On Tue, Feb 16, 2021 at 02:31:03PM -0700, Al Stone wrote:
> > Would you believe last week's meeting was canceled, too?  Not sure
> > why the chair/co-chair are doing this but I'm finding it a little
> > frustrating.
> > 
> > We'll try again this week ... again, apologies for the delays.  I'd
> > recommend going with the last version posted just so progress can be
> > made.  The spec can always be fixed later.
> 
> Thanks, I'll send the acpica changes for review and follow with QEMU and
> Linux patches. These things also take time so I might as well start in
> parallel.
> 
> Thanks,
> Jean

As of today, the proposal has been approved for inclusion in the next
release of the ACPI spec (whatever version gets released post the 6.4
version that just came out).

Congratulations ?!? :)

And thanks to all for their patience during this process.  You now
have the dubious disctinction of being the very first table added
to the spec that _started_ as open source.

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
