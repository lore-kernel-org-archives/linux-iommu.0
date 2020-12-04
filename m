Return-Path: <SRS0=gcKa=FI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A343C4361A
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 20:18:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45DE22B40
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 20:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45DE22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4676087269;
	Fri,  4 Dec 2020 20:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRixOa_mV3pw; Fri,  4 Dec 2020 20:18:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BCAE98720A;
	Fri,  4 Dec 2020 20:18:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE6DAC0FA8;
	Fri,  4 Dec 2020 20:18:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23237C013B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ECF1F2E2FE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ctdi0KMIh-Qp for <iommu@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 20:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 03F9D204B5
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607113113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2unnKeiujL4yyCkCFH51mlWGMKqzY5P/V0x5W95sFnk=;
 b=hx99wgpENkJ5ScFlc62ybC6jsoqYiHW0At+kjIkmM34keyWQ9JSQBlRLC+k1oBi32ozIMH
 7YBwEfdkay4yb3QFe/GLGCI9/LTe2Ecwq8dAZkdddzAPi2s/avRWuU5EVA+Rtau/7XRo+i
 JvANWEBA/gs/wDrXIV+OUrevJQ6agkA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-j06LsTKkP9iW1O22kAZQow-1; Fri, 04 Dec 2020 15:18:27 -0500
X-MC-Unique: j06LsTKkP9iW1O22kAZQow-1
Received: by mail-io1-f69.google.com with SMTP id k10so6267833ios.19
 for <iommu@lists.linux-foundation.org>; Fri, 04 Dec 2020 12:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2unnKeiujL4yyCkCFH51mlWGMKqzY5P/V0x5W95sFnk=;
 b=p4kaDu1n9A/D2Jz/nzuqHF3/tGIl+eVyGItXYbeRcMaiEdQeeYlANhTN804nA5PNLx
 9oS5mMqcWNpjo8/JqQZYju8wI4EaSpQSTbLn76WGAvfyZQlS1+m47cVZOxeaWedyA+EC
 eg4urmoZcMeDAbfFUkh8ApFtAw5N7t4nxUG8/Zkk2Pnj/jHFX6YYiOhmzo6LE4vWIxTo
 Bbcny4IaakjKvV82stOPFzX/8bmuWwfXzLVO+Ooaa6xMpS7Gteye552s6LjBbeCy2dWs
 ZJYPUrFv9APL88CbanwoJBV/8WRseqLPUiGQy0otu8EyZpyvIuy0NkMDYaEpvWiwu0cn
 Fk3w==
X-Gm-Message-State: AOAM5315BQ548iKvXTGU/VDbPTLZ1Z16I4ukIZYCGLT/nk7RfTnZeyz1
 uo+/qqoCmbw9L0ugN4ITaLr1jKplpZ7tYPXYARClYsS9Kr3CqIWfqwnlWtGvWjXBrpB+StPXAww
 9x5s8SpX17jUThEj+khwZcS9aJ0byLg==
X-Received: by 2002:a02:6a59:: with SMTP id m25mr8500510jaf.132.1607113107115; 
 Fri, 04 Dec 2020 12:18:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwveM6ZDkNYEs2isA605pt4ALCsbQkcK0PslXgyU7JrYrtOg4rTkA4DZ+N/9c7Ihh6pkO2HHQ==
X-Received: by 2002:a02:6a59:: with SMTP id m25mr8500494jaf.132.1607113106865; 
 Fri, 04 Dec 2020 12:18:26 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
 by smtp.gmail.com with ESMTPSA id l23sm1822988iob.42.2020.12.04.12.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 12:18:26 -0800 (PST)
Date: Fri, 4 Dec 2020 13:18:25 -0700
From: Al Stone <ahs3@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20201204201825.GG4343@redhat.com>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
MIME-Version: 1.0
In-Reply-To: <20201204180924.GA1922896@myrica>
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

On 04 Dec 2020 19:09, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Thu, Dec 03, 2020 at 04:01:27PM -0700, Al Stone wrote:
> > On 03 Dec 2020 22:21, Yinghan Yang wrote:
> > > Hi Jean,
> > > 
> > > I'm sorry for the delayed response. I think the new "PCI range node" description makes sense. Could you please make this change in the proposal?
> > > 
> > > Other than that, the proposal looks good to go.
> 
> Thanks for the feedback, I made the change
> 
> > > 
> > > Thanks,
> > > Yinghan
> > 
> > Jean, were you going to update your existing doc first?  If you
> > do that, then I can cut and paste the changes into the existing
> > ASWG proposal.  Or do you need to send out an RFC to the mailing
> > list first and finalize it there?
> 
> I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> You can incorporate it into the ASWG proposal.
> Changes since v8:
> * One typo (s/programing/programming/)
> * Modified the PCI Range node to include a segment range.
> 
> I also updated the Linux and QEMU implementations on branch
> virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> https://jpbrucker.net/git/qemu/
> 
> Thanks again for helping with this
> 
> Jean

Perfect.  Thanks.  I'll update the ASWG info right away.

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
