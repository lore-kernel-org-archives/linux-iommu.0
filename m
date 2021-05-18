Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A5C433B4
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 18:59:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43064610A2
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 18:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43064610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70F1F40271;
	Tue, 18 May 2021 18:59:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wsxsQ_O8aYI; Tue, 18 May 2021 18:59:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35D5240356;
	Tue, 18 May 2021 18:59:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11F21C000E;
	Tue, 18 May 2021 18:59:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22C86C0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BD8440534
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KWtTr1z00CZn for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 18:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C3BF4053E
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621364344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmvqAF/tGZxnpJT45xMDZ2Iz1NsXhbJqP8uJhgy88+E=;
 b=IVG3mqEwATXwFVa7K29SahRkm7rsTxsnHLVqMXuLWcgyxJPyB+56m2G4lUs6/LOxpnMkeb
 g7bDOymbrltkHCScmIfEl5xff3ESh9uRSiAKpf6ayrHoqawhkePeIOLo4Ut+H3HClmJM6y
 huScEERJ/0jQ6zZ6gegovaOfE1SAXBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-msU198vYOKCHIds7qVJYZw-1; Tue, 18 May 2021 14:58:59 -0400
X-MC-Unique: msU198vYOKCHIds7qVJYZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED0AF80006E;
 Tue, 18 May 2021 18:58:56 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E08931037E88;
 Tue, 18 May 2021 18:58:55 +0000 (UTC)
Date: Tue, 18 May 2021 12:58:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [RFC PATCH v3 1/8] iommu: Evolve the device fault reporting
 framework
Message-ID: <20210518125843.68552b67.alex.williamson@redhat.com>
In-Reply-To: <20210409034420.1799-2-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-2-lushenming@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 9 Apr 2021 11:44:13 +0800
Shenming Lu <lushenming@huawei.com> wrote:

> This patch follows the discussion here:
> 
> https://lore.kernel.org/linux-acpi/YAaxjmJW+ZMvrhac@myrica/
> 
> Besides SVA/vSVA, such as VFIO may also enable (2nd level) IOPF to remove
> pinning restriction. In order to better support more scenarios of using
> device faults, we extend iommu_register_fault_handler() with flags and
> introduce FAULT_REPORT_ to describe the device fault reporting capability
> under a specific configuration.
> 
> Note that we don't further distinguish recoverable and unrecoverable faults
> by flags in the fault reporting cap, having PAGE_FAULT_REPORT_ +
> UNRECOV_FAULT_REPORT_ seems not a clean way.
> 
> In addition, still take VFIO as an example, in nested mode, the 1st level
> and 2nd level fault reporting may be configured separately and currently
> each device can only register one iommu dev fault handler, so we add a
> handler update interface for this.


IIUC, you're introducing flags for the fault handler callout, which
essentially allows the IOMMU layer to filter which types of faults the
handler can receive.  You then need an update function to modify those
flags.  Why can't the handler itself perform this filtering?  For
instance in your vfio example, the handler registered by the type1
backend could itself return fault until the fault transfer path to the
device driver is established.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
