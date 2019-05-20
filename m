Return-Path: <SRS0=A2w3=TU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE097C04AAF
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 13:17:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0ED20815
	for <iommu@archiver.kernel.org>; Mon, 20 May 2019 13:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0ED20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B9EAD7A;
	Mon, 20 May 2019 13:17:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 41407CF6
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 13:17:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DADBD83A
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 13:17:02 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id c15so8774645qkl.2
	for <iommu@lists.linux-foundation.org>;
	Mon, 20 May 2019 06:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=bZcyqtPfiR8OnSe7X+YvU6P3WmrTts8Lp+0qyg4aj2M=;
	b=qvbwxvXlnCwRXEsSmjiG+s2t8f6LT/JZ3iKegCdUy/Ju0oBMpdrDavdVCZ47gFsygA
	9KoczRoRG1DqT3SpkNtz/eU/oTuxKMkSfeOE9Jg5d0Cso80ZbthpYWh9Nb4tvDGIVPTp
	cI1Q4PI0ltEf+Ifhx3Qe1/9kXiDv6dwKCKcj2b7h63MobkTKKHB7X0MQAxX+x09BTscN
	BEpEUuoRUggUF8N+XApI0fjr5P39WCsPuT11G6Wd3hbs/S4hpdWZQt12uTQryC+7ooDr
	C9dahgROL45svPwkx0K9ZGdruWW48xzdSkz62v/PmbR8gkUUHTeTkDchk02+jnF79QfA
	iZuQ==
X-Gm-Message-State: APjAAAUzVIxpFxjSPg1bcd8+oKZHgeL4NZ86aYjeHRjrjuVg41QPQvAP
	09xYgXNDtQxjBghPMcaasU9Z0Q==
X-Google-Smtp-Source: APXvYqw0FqLkxwDq3if4j/PtdUGJI5ox1BH3UIwaju3gNcXX5ayK/jpLunGqH+2wq+Rcle7lAXdfbA==
X-Received: by 2002:a37:4c02:: with SMTP id z2mr46791719qka.1.1558358222050;
	Mon, 20 May 2019 06:17:02 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	d16sm11577917qtd.73.2019.05.20.06.16.59
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 06:17:00 -0700 (PDT)
Date: Mon, 20 May 2019 09:16:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190520090939-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<87a7go71hz.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a7go71hz.fsf@morokweng.localdomain>
Cc: Mike Anderson <andmike@linux.ibm.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jason Wang <jasowang@redhat.com>, Alexey Kardashevskiy <aik@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@ozlabs.org>,
	iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> I rephrased it in terms of address translation. What do you think of
> this version? The flag name is slightly different too:
> 
> 
> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
>     with the exception that address translation is guaranteed to be
>     unnecessary when accessing memory addresses supplied to the device
>     by the driver. Which is to say, the device will always use physical
>     addresses matching addresses used by the driver (typically meaning
>     physical addresses used by the CPU) and not translated further. This
>     flag should be set by the guest if offered, but to allow for
>     backward-compatibility device implementations allow for it to be
>     left unset by the guest. It is an error to set both this flag and
>     VIRTIO_F_ACCESS_PLATFORM.


OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
drivers. This is why devices fail when it's not negotiated.

This confuses me.
If driver is unpriveledged then what happens with this flag?
It can supply any address it wants. Will that corrupt kernel
memory?

-- 
MST
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
