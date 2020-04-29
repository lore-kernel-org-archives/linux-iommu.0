Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F1C83004
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D609B20775
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsO97eGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D609B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 83E5922E89;
	Wed, 29 Apr 2020 09:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOWEu-Ca21tZ; Wed, 29 Apr 2020 09:52:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 027AE20406;
	Wed, 29 Apr 2020 09:52:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5809C0864;
	Wed, 29 Apr 2020 09:52:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D926C0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 09:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 629A9882EC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 09:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KqcWr3SPGYPm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 09:52:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9C5BF88309
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 09:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588153932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IZWphU6PtHquCqE0i6um38oK8paShAt54dfHnz8KmQ=;
 b=CsO97eGEro2k/1INTTfYCmqXYsEZCa94o+Uc9h222lwfBC2Qp9/eY2eRzR4EPG0SNO4Kh9
 oF/CCAbvdItLITpSscG5xrVmYYWhZTHVzcBp4YHreXkbBLDgqCaEh0AUpjgLwpsZnH++Tj
 pyoUGCesv002+pJ+R9jnE26+3AGKFqY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-6DuUEx61OlKk333zseNZ5w-1; Wed, 29 Apr 2020 05:52:10 -0400
X-MC-Unique: 6DuUEx61OlKk333zseNZ5w-1
Received: by mail-wr1-f69.google.com with SMTP id i10so1451874wrq.8
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 02:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7IZWphU6PtHquCqE0i6um38oK8paShAt54dfHnz8KmQ=;
 b=ZK5XWUK1wnoMPMvdnOQgWvJ/lovVjGfvD8AoXdN+DKYxF7fjDQve/5xLX218gTsQpp
 hfX4b/cCg2tCqph7gkrZuhxjLWoUxJaMx/hds1yuZlJGEoHEqrAnInUkrIUrUbHzkJdq
 nczLnsTXeW1L3BLaEf7++IHcbKHWWjUgruAiI0ArqM1FOvZT4BI8D90L08fr8ZVuBkJB
 i+Qj0vFyZxLFvgGG5j5DwLt4l/2VNCitLrrJIpCFZktSAI1ExiStV/LuDPi1md0TgdMS
 +LlFQOdsINA0uJBRgJe4iz+4LOqIzMPGWc+P3GRRJIRo5MAqaSYtDsaKXIYFom1POKNS
 ss7w==
X-Gm-Message-State: AGi0Pub/YADUge9grduz6o3tUnso5ZMOdRSEcDt66/7TQVPUtQZyNnWC
 h1RqCrmnwP1NQxLnI5oNMeyyrmKo3eq7LXVHzjTOgnEG2PyUJwL70e4B5BnGzoaJRuaKFCjezae
 YdxGw5NJjbm7yKv/ojwHEU04jenOC6w==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr37134236wrw.267.1588153929721; 
 Wed, 29 Apr 2020 02:52:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRdM34lQ/3OGcwItQoxnplrvwZwErBKY2jH3AvTLAgP599BhH8xTgBBhPvAXTcnaVguo7aJg==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr37134206wrw.267.1588153929489; 
 Wed, 29 Apr 2020 02:52:09 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 s24sm7232898wmj.28.2020.04.29.02.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 02:52:08 -0700 (PDT)
Date: Wed, 29 Apr 2020 05:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429055125-mutt-send-email-mst@kernel.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
MIME-Version: 1.0
In-Reply-To: <20200429094410.GD5097@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, will@kernel.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
 christoffer.dall@arm.com, pratikp@codeaurora.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 stefano.stabellini@xilinx.com, alex.bennee@linaro.org,
 linux-kernel@vger.kernel.org
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

On Wed, Apr 29, 2020 at 03:14:10PM +0530, Srivatsa Vaddagiri wrote:
> * Michael S. Tsirkin <mst@redhat.com> [2020-04-29 02:50:41]:
> 
> > So it seems that with modern Linux, all one needs
> > to do on x86 is mark the device as untrusted.
> > It's already possible to do this with ACPI and with OF - would that be
> > sufficient for achieving what this patchset is trying to do?
> 
> In my case, its not sufficient to just mark virtio device untrusted and thus
> activate the use of swiotlb. All of the secondary VM memory, including those
> allocate by swiotlb driver, is private to it.

So why not make the bounce buffer memory shared then?

> An additional piece of memory is
> available to secondary VM which is shared between VMs and which is where I need
> swiotlb driver to do its work.
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
