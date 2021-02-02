Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86445C433E6
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:18:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D225764E9C
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 09:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D225764E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 93262854B4;
	Tue,  2 Feb 2021 09:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lafynUp-uHSA; Tue,  2 Feb 2021 09:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2091C84ABB;
	Tue,  2 Feb 2021 09:18:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 043C0C0174;
	Tue,  2 Feb 2021 09:18:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A6F2C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 84CDC8506E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6bDUjcX6tH3F for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 09:18:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 31DAA84ABB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 09:18:00 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id d16so19574001wro.11
 for <iommu@lists.linux-foundation.org>; Tue, 02 Feb 2021 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nsYsJDtR1d9Blva/Q9h14GF6lVxGSiybGoWK9bo6iFs=;
 b=FaW/wiOxSBKdQqCys1DLBERUvvdzRCZrteyKqGjDzav1N7UrU284sQu1hl5fTTV/+5
 DJInuo+IRUJofUuhylMQp4VRnCGE3zI+rp1RYfGAxX22x5I3jmlAXjv0WfC623LQG3L1
 ZI6DMjQHt0FYpFrx61wYfuSCDKnlYqlOQKJzYcN0rc3n7HuDWba//bXNUeIH34SAlUV5
 iJo1CIKfgkBoCvnZi8KHMJ3pZF1AExht1vBr9XtZ4OoKuUcITk0L+nxqrfAqfwBIbQcI
 2AOKrRqqUU+B/0tpOKKMsp++QZyzbHLpAC55C1QNK+KSVHiF80Xpat6VzTEpmS5Gd8dx
 DZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nsYsJDtR1d9Blva/Q9h14GF6lVxGSiybGoWK9bo6iFs=;
 b=gF82Agy76c7fqs15+80gkOqWFCVVLwkAKu3PmPWEIjolXLLNtkn7OOHlDq/sJEChLU
 sSibK4/O0srUtywZ68aeJKmFGh6pEJflkTWYZ8z4tSDCzvxbvysOHl+EpgralUsteqGA
 FTZ9QkB6pHprziYDkIwoyLSz3+EIO3liKKkoK2M4ywNVFDLiDe+HKrq1kXPp8Qrb5uxL
 cL6wNTw+lJf9BflDGK4BVeZ0MbnhDABH6DpYhHEW804YZNz9uTkqg1O5c9wmolRPTZyp
 mcwGtX0+aVMZuiq93aSEhAopDbqEeeA176Iay0zpoZi6v+MujxaBf8XsyAKYs+X9ubBZ
 gvlA==
X-Gm-Message-State: AOAM5301MmdEDStTwn5oePnifeT9JshR8/x3gGlCBU07cs5GW/53kGpU
 5xPY3mFuyCvRvANp1TBM816S2A==
X-Google-Smtp-Source: ABdhPJwP4EshOFDUtLudblIgKW+B6pw8wNO9vlovqKBpD/vXrwNLGcrTkc1NONasztFwyxWeYhIPvg==
X-Received: by 2002:a5d:5304:: with SMTP id e4mr22182784wrv.167.1612257478614; 
 Tue, 02 Feb 2021 01:17:58 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w4sm2032584wmc.13.2021.02.02.01.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 01:17:57 -0800 (PST)
Date: Tue, 2 Feb 2021 10:17:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Al Stone <ahs3@redhat.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <YBkYsSHGUfG91NoN@myrica>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201106135745.GB974750@myrica>
 <MW2PR2101MB11301F2185D1C9016310728E80F21@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201203230127.GD4343@redhat.com>
 <20201204180924.GA1922896@myrica>
 <20201204201825.GG4343@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204201825.GG4343@redhat.com>
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

Hi Al,

On Fri, Dec 04, 2020 at 01:18:25PM -0700, Al Stone wrote:
> > I updated the doc: https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
> > You can incorporate it into the ASWG proposal.
> > Changes since v8:
> > * One typo (s/programing/programming/)
> > * Modified the PCI Range node to include a segment range.
> > 
> > I also updated the Linux and QEMU implementations on branch
> > virtio-iommu/devel in https://jpbrucker.net/git/linux/ and
> > https://jpbrucker.net/git/qemu/
> > 
> > Thanks again for helping with this
> > 
> > Jean
> 
> Perfect.  Thanks.  I'll update the ASWG info right away.

Has there been any more feedback on the VIOT specification? I'm wondering
when we can start upstreaming support for it.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
