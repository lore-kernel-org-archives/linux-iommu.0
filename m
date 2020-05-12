Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AECCA90AF
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 16:47:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3DA20714
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clatA++v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3DA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 500C489485;
	Tue, 12 May 2020 16:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gX6x4JyRA0qv; Tue, 12 May 2020 16:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D4F9588558;
	Tue, 12 May 2020 16:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C17CDC0178;
	Tue, 12 May 2020 16:47:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3CF4C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 16:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E1F438871A
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 16:47:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Muf1XuGFatn4 for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 16:47:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4D8F88710
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 16:47:14 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id z72so14620301wmc.2
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jyNo/FD8DQaK2ucnwvUAdPJG4owWhdE2wKYx5rVGxYI=;
 b=clatA++vihr5sTI7dUupzacVS/N7lCVLYB3yV/N5dBG1B2tTi3SyMIL+AT9rTNF4RM
 whaaPPqLKdjztbhQ6G88AUdB+KZ6RgutaBFsYMakAU5CewEq5W5Z2IKQNcDNtMNOdJia
 S+Wi+0vcoouQSemfz+P2d3pyqaWJGMB1Teackt4osIMCTle/Q/wCH0Ojbm5v82RWocy0
 gxsD8/lNkUdxZjnAAheAO7kqpIMxV9U2axJMnC1aeKnEubwnt8djZJ4/U1FMtzNtqjSj
 9bb/GI48q0BZqY/mg0V1iXr6dJRTXCAScM395uW6IHfakeiexg7rOaqobfoR4E0ezkNz
 gIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jyNo/FD8DQaK2ucnwvUAdPJG4owWhdE2wKYx5rVGxYI=;
 b=nkzDqcNaNF/sMyR3cWAhcylrFn5lifmmxW9/sXkCj8VIqiPQI8q3lytOfqQTR6TB5j
 KFmBzjpWKyf5z9hSZqEMDwGhHvcm9xB1vFwKpXaa1DpfGgtJgeVqWjR5Aly5yXlcbqoV
 uaNM0Ps/Zdk5iqzu3IgOdiRZ9yIzVSWW228Hg6KgklMz1KISTwabo7JKT9cm6utfqpbK
 NRJHJgSDwgGO5Pd7oaEs5zJ6asYyl0HOsh4xc9r55qCcsHqZgTwVcpundxZRJdWfNImK
 wCXS9AcVKTp8Ysdz1/glaYquXGXzHNbJLp2Weg08f25GK83MjH6FkUIqbPztnGQ0pmlu
 ahnQ==
X-Gm-Message-State: AGi0PuZVW6EER7EUPfVRFAQxcp569LlZozDi++nuCa2FYXmhL3AiyYc5
 bD6X1pQG0P1acIDG+bzYIlbJOg==
X-Google-Smtp-Source: APiQypK91Q773XCjNUOrLaxJtSW2iijZMl+ZhfoxDdGoHWSVwaGxx48FOaDpn4r3TPN8Hn4Crs5OJA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr36930985wmc.76.1589302033401; 
 Tue, 12 May 2020 09:47:13 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id a8sm23851429wrg.85.2020.05.12.09.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:47:12 -0700 (PDT)
Date: Tue, 12 May 2020 18:47:03 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200512164703.GA1902@myrica>
References: <20200505093004.1935-1-bbhushan2@marvell.com>
 <20200512105149-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512105149-mutt-send-email-mst@kernel.org>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Bharat Bhushan <bbhushan2@marvell.com>, eric.auger.pro@gmail.com
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

On Tue, May 12, 2020 at 10:53:39AM -0400, Michael S. Tsirkin wrote:
> >  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >  			       struct virtio_iommu_probe_resv_mem *mem,
> >  			       size_t len)
> > @@ -499,6 +513,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >  			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >  		default:
> >  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >  		}
> 
> So given this is necessary early in boot, how about we
> add this in the config space? And maybe ACPI too ...

A page_size_mask field is already in the config space and applies to all
endpoints. Here we add a property to override the global value for
individual endpoints. It can be necessary when mixing physical (pass-
through) and virtual endpoints under the same virtio-iommu device.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
