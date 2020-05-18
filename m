Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84144C433E0
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 22:15:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ABD20657
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 22:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMXdM/Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ABD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C96D8220DD;
	Mon, 18 May 2020 22:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uTyMzLDOl-DG; Mon, 18 May 2020 22:15:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 507D4220D6;
	Mon, 18 May 2020 22:15:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D10DC0881;
	Mon, 18 May 2020 22:15:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63A05C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 22:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5371085F08
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 22:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0jv2hEBdWyrD for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 22:15:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 776DC85EF1
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589840138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=prsCkCxLy7bTtHoNJZEl6S+IBLY3Vu826GUD9uYHGiY=;
 b=GMXdM/Zyw4VueoKJVOtQK8OAUpNChoOfVS5QTjDFh4uHb4zo6JI4xfJizVSJu1bNoTs206
 8txUBQw1Jy8GdgRWfw4uXFjS+mYolWDdWAqOn6iGz1tVgplF43AejxwtVGWyTi6+p6ycni
 RY4L/k8PIlt/qfsYRqCFB6HtWtTRuKs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-0cKThxDhNnu8C5HuBVYkMw-1; Mon, 18 May 2020 18:15:37 -0400
X-MC-Unique: 0cKThxDhNnu8C5HuBVYkMw-1
Received: by mail-qk1-f197.google.com with SMTP id m15so12287004qka.20
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 15:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=prsCkCxLy7bTtHoNJZEl6S+IBLY3Vu826GUD9uYHGiY=;
 b=FMtR0GOaUsqNi4M+Gyqt3NrLvYRMlwWE4eovWltkNRCHH9p77ao1et3chAG+NvTNDI
 m9yZG/f5dVmi882/ZIMrg3E5fm32vs5myTrrQBztjNtt9ic64rLue07fOu3EBwzOn7eV
 Uk9ZOD8PlWi0Bg4QfZVbnufs+RmYUfnoGWbOyAToP+k8J0wlbdqSEGE5ZkN/jtl4AVFp
 8vgFvfn9lkwefWib2tLcG91SMZEfph5jxCm5Z8tPRtimInpEcFBwf2BRfIRc5gxJnOqu
 OpJynWpVxqshjjDW050GBBJHrmmgTNRDu2Bq99NvqbC+6YLb4bE1iq8SNb0eVrskU8bG
 QFXA==
X-Gm-Message-State: AOAM530uWRRwyhMUSqWalhccbY6VX/UnahuNO1FKiSyYWSbFzZY+yq5t
 NBi49EyLSdlHUnRFEdA22tlAHwGmwNT9Wlg+eJq4cht1M84BwPqA8EfuiHqHzQDAi/HFwhjvlAA
 JJ+aU57/zo8qzrVavGQ5k3XvsEzAb5A==
X-Received: by 2002:ac8:34a2:: with SMTP id w31mr19243748qtb.368.1589840136567; 
 Mon, 18 May 2020 15:15:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztGJSlm+3MgWXGvF/R/sy62O7hJQ1szJo28kqLWu4sfGu/yMbfNJHY/6iPOkZmIF4l2XweMg==
X-Received: by 2002:ac8:34a2:: with SMTP id w31mr19243709qtb.368.1589840136227; 
 Mon, 18 May 2020 15:15:36 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id n206sm9251212qke.20.2020.05.18.15.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 15:15:33 -0700 (PDT)
Date: Mon, 18 May 2020 15:15:31 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200518221531.5mddl4fatu5hvbyb@cantor>
Mail-Followup-To: Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
 <20200518132656.GL8135@suse.de>
MIME-Version: 1.0
In-Reply-To: <20200518132656.GL8135@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon May 18 20, Joerg Roedel wrote:
>On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
>> But that's not what this is; this is (supposed to be) the exact same "don't
>> actually perform the attach yet" logic as before, just restricting it to
>> default domains in the one place that it actually needs to be, so as not to
>> fundamentally bugger up iommu_attach_device() in a way that prevents it from
>> working as expected at the correct point later.
>
>You are right, that is better. I tested it and it seems to work. Updated
>diff attached, with a minor cleanup included. Mind sending it as a
>proper patch I can send upstream?
>
>Thanks,
>
>	Joerg
>

I should have this tested this afternoon.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
