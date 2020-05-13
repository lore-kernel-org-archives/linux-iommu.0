Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C0CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 10:45:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945AF20675
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 10:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC/3PHBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945AF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C68A85F67;
	Wed, 13 May 2020 10:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eycS3MFSDmoV; Wed, 13 May 2020 10:45:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96EA285F3E;
	Wed, 13 May 2020 10:45:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 758ACC088B;
	Wed, 13 May 2020 10:45:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BA3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 549762154F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WaiYr0ujdk59 for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 10:45:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1368621543
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 10:45:49 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id g14so11536471wme.1
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SmNmuU5Aep/IGe3eSTrjS6oLXRSTGYhw6IFWVs9Iuqc=;
 b=UC/3PHBoun3v1rx7wxmHxa5RFjjGfNLNpaCn6pfowgebDNYC32O8cp+YJHnvOEQaLk
 Nz+CjUwKVJxOPjAc+Am8F0hqrPMDiwM2aoGX5r90B7BN76cDKPh6nr/YlAAyxleAFf96
 NlJANIMYq5DpzZ6aRKewyuez8+MQkdZd9DSO/gtHi1WlvxunYaH+dufi8aFhaGuP+ph9
 zIeuSIUI2UQyBg6TbiMKe6swjsAYzSJuHyWPZUsJLZuCjKUsD55B1251N8tC3tLD40aj
 agDxckNYt6eUv6ydoTJ+56CrQqMMdERHKWIgm0l69OYmgLIINQMDX3EQTlKycym24/V8
 XC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SmNmuU5Aep/IGe3eSTrjS6oLXRSTGYhw6IFWVs9Iuqc=;
 b=jK8EHlmvVxYYkl0hBXh4V+9+T64qyFfR2Kk5Rkh7ewU/R4aHMiaLRuRTAZJ/6LAzkU
 fIY8Duh8umQjhNyCU1hnwULxGeq8sBu4yYzZE5a/QJu+3rG0lrLGwEbhruLZaTMbF2hD
 aO15Wr00/qhu5PGN/pR8I9USlXEekUU8akDpuM1PpQKwRAt0olVfLeAA+NaTI0sU0LVU
 ZlgP3V6vCPAedqrvonG35aBWxDtQvjpe1M2XED5/V7T3xLDnLwt3J8EEzJe0Z9bU1/+h
 iEL/PN+d6JjZVYfySwW2XyfGWK6b4QHeg0OQtvci4EHaYGQkMgmppYwO8TxDy7sKDWW6
 Sw/g==
X-Gm-Message-State: AGi0PubgFcHZggXjf6zNzZnSIFQcMHAk8WzqKrjz8zvZRnm4gkZUfGj1
 7OLZzNeRd9pbsB2NA9h0BM3Gdw==
X-Google-Smtp-Source: APiQypJmft0/u1tO86sQKhZsj1C97uNs/XnCzX9fNiwnwt1E0uNsNm62LaV0mFWoR6TcsuBFsKHelA==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr39555553wma.118.1589366747407; 
 Wed, 13 May 2020 03:45:47 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id g135sm17966353wme.22.2020.05.13.03.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:45:46 -0700 (PDT)
Date: Wed, 13 May 2020 12:45:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap
 supported by endpoint
Message-ID: <20200513104537.GB214296@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200505200659-mutt-send-email-mst@kernel.org>
 <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1966A23A0298654CA6965FB9E3BF0@MWHPR1801MB1966.namprd18.prod.outlook.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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

On Wed, May 13, 2020 at 09:15:22AM +0000, Bharat Bhushan wrote:
> Hi Jean,
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 6, 2020 5:53 AM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: jean-philippe@linaro.org; joro@8bytes.org; jasowang@redhat.com;
> > virtualization@lists.linux-foundation.org; iommu@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org; eric.auger.pro@gmail.com; eric.auger@redhat.com
> > Subject: [EXT] Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
> > endpoint
[...]
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	__le64					pgsize_bitmap;
> > > +};
> > > +
> > 
> > This is UAPI. Document the format of pgsize_bitmap please.
> 
> I do not see uapi documentation in "Documentation" folder of other data struct in this file, am I missing something?

I'm not the one requesting this change, but I'm guessing you should add a
comment in this header, above pgsize_bitmap (which should actually be
called page_size_mask to follow the spec). I guess I'd add:

/* Same format as virtio_iommu_config::page_size_mask */

for this field, and then maybe change the comment of virtio_iommu_config,
currently "/* Supported page sizes */", to something more precise such as:

/*
 * Bitmap of supported page sizes. The least significant bit indicates the
 * smallest granularity and the other bits are hints indicating optimal
 * block sizes.
 */

But I don't know how much should be spelled out here, since those details
are available in the spec.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
