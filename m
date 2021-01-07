Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7DC433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA7623100
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 02:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA7623100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FDD28678B;
	Thu,  7 Jan 2021 02:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1aFHqysLWT2; Thu,  7 Jan 2021 02:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E278786789;
	Thu,  7 Jan 2021 02:51:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB533C0891;
	Thu,  7 Jan 2021 02:51:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABD48C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 02:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7A1A720404
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 02:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jdgjk2HPc2ID for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 02:51:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by silver.osuosl.org (Postfix) with ESMTPS id 256B52036D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 02:51:46 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id d17so7749360ejy.9
 for <iommu@lists.linux-foundation.org>; Wed, 06 Jan 2021 18:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8LO5/Phbq28+31YDa1UZ1eQndglIwHyPOPdAo8T96Wc=;
 b=HQhQLnWS/ZJhdarKXSdd9H4qvqQ2V+N1W+bmCj0unK8v+b1kFb1bhI3HaS9/i50hzT
 kjnzni0TONbDtitbOV6IQqx+GH4UXTeabroXuypuTDDPupJ76lnHJOx66Ubp1AM2qBCP
 DdR/dJqziE60ULJpT4G1r7LtGQ4lkufUh1z85qvdRuzVd1H+YkUGZ32a4e6wu7cQF2AT
 qZI51OWODB4y0r+MMljmwvkatkq2Ym0xpyzFNmpM89mXs0bwDHxVo5YocIdmCoyUEgPk
 pn769EBOtvuoqxUfOSg3D7K1mvP8t0awPntTVNXSxKKzJka6xeC11b4yjF7HNVm95RtS
 ujHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8LO5/Phbq28+31YDa1UZ1eQndglIwHyPOPdAo8T96Wc=;
 b=oEf40V53ZsbvdRTGPq5PKjS/cuThp3M06z8LLzZMH17eRI9VhbuAiLkCLaZFSDXgRP
 4s7TvRlog1CsiaqHbeXPwW2iAcOxJbePe7k8sTngVJUMWZFyP8IL3SHKQ/6MJOU4LXLW
 Je4TQqeAJXl18P8opzF3MIqMEBZkJU5uwwHJRTYbkVo6VacGo20lQGobeyDMwVRyDpua
 ap/9LXv8q2O1welR2YIbie5x3TuF322Kw4sVS5w6ELIf6cLCaNho9aWRmGrcZlsFTids
 oQogRmEjQtS0x1qdaeQq5WTm11wfdxjbp7SEJIpa61fsvGgqyCMVvxOdG137Smlf8dJ3
 yzCA==
X-Gm-Message-State: AOAM5303CpG04lqxKJlzfsJSfFEoDuDaCrOwCGUOLuTGU+e27fH8VwaJ
 JUKsOaFiTAYVVbotfa/2bRfWhsWpS8u0VVkPOCk=
X-Google-Smtp-Source: ABdhPJzTIJZrgbwShljzLzrtpDr7Vf+8G5j4QQqhPuCnMXI9QmwqyOOOU6SGWBdt80TvLjY0rucjD3/iZWMmlgN8ZXw=
X-Received: by 2002:a17:906:417:: with SMTP id
 d23mr4922263eja.19.1609987904487; 
 Wed, 06 Jan 2021 18:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20201223062412.343-1-zhenzhong.duan@gmail.com>
 <20210104190240.GF6029@char.us.oracle.com>
In-Reply-To: <20210104190240.GF6029@char.us.oracle.com>
From: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date: Thu, 7 Jan 2021 10:51:33 +0800
Message-ID: <CAFH1YnP5p0o+Ux9O_VXtx2QFYQjc16tzsR4txJdA8pm-WmtORQ@mail.gmail.com>
Subject: Re: [PATCH] x86/iommu: Fix two minimal issues in check_iommu_entries()
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: will@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 joe@perches.com, Thomas Gleixner <tglx@linutronix.de>, zhongjiang@huawei.com
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

On Tue, Jan 5, 2021 at 3:04 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Dec 23, 2020 at 02:24:12PM +0800, Zhenzhong Duan wrote:
> > check_iommu_entries() checks for cyclic dependency in iommu entries
> > and fixes the cyclic dependency by setting x->depend to NULL. But
> > this repairing isn't correct if q is in front of p, there will be
> > "EXECUTION ORDER INVALID!" report following. Fix it by NULLing
> > whichever in the front.
> >
> > The second issue is about the report of exectuion order reverse,
> > the order is reversed incorrectly in the report, fix it.
>
> Heya!
>
> When you debugged this, did you by any chance save the
> serial logs and the debug logs to double-check it?

Hi Konrad,

The iommu_table_entry is sorted by sort_iommu_table() and
check_iommu_entries() finds nothing abnormal,
so there is no related logs to check.

Sorry for my poor english, I'm not saying there is order reverse, even
if there is, it will be repaired by sort_iommu_table(). Then
check_iommu_entries() report nothing.
What I mean is about check_iommu_entries() itself, below printk isn't correct.

printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
                               p->detect, q->detect);

Should be:

printk(KERN_ERR "EXECUTION ORDER INVALID! %pS should be called before %pS!\n",
                               q->detect, p->detect);

Regards
Zhenzhong
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
