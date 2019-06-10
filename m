Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF5C31E41
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8920620859
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BVi3rXe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8920620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1173EB3E;
	Mon, 10 Jun 2019 14:54:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 04D1A2F
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 14:54:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com
	[209.85.221.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 68FCB174
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 14:54:25 +0000 (UTC)
Received: by mail-vk1-f196.google.com with SMTP id 125so1704482vkb.4
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HBy9mlIx6f1ckhMxMH/Wiz5DhTWHFCPX4zeEAJIdzTE=;
	b=BVi3rXe2/KugjTlNlPcpf2KyS+kd6TzwaRjTYOBqUDoP0ySDW/7ANUn8qtvQeomFq0
	6NZkgIcpD29Z3NxCclmpssuc0uVdNWF/wsPBaCYsCMDDlRnB7gA8HNTFnxkcvE+yoFZL
	T48YcrPMHqQ4HlFJRTYzpQaClRTfGfFufgI0HC/jSCLO6izLfC+0XMKVxHJbM+1bu3az
	1n6G47VzZzlpXRhQBBjUrwl5+X2gT1pSzs9o+YgzJsMfgKBbdLmODs/nBFQKv6WIWJIR
	4rzIv0v7W3WBtucArXz7IFPGU57HAS0TdXmyPwGWyul64U8BxsLVcPivqi7gJqx/QSyZ
	VFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HBy9mlIx6f1ckhMxMH/Wiz5DhTWHFCPX4zeEAJIdzTE=;
	b=CW1GDUArZbNfEERrTUdrHYvb5FSAZJwyACRUFmklyq4O2CBeX+B1ghOZ3TAE30t1qJ
	KcXK9poDAUGj4CtR8KGfOZyosRWzEhUO5petxKCOX4P8w0Nd83BtrEaYLH0mUpf/eOMS
	nFfAcjRolYZDDwXWW3hzGqZP2SQwOsQCWrmgTY/GYNHbPCsI2jiuBc4vv0AKSo08wF8s
	p4bxkJLuOL2wmikTn3NPbu6kJNeqhglD/6Hp6JhFmYcIJdXOWPdTmdOA//zc700Doz2j
	CV/zkq+0H54v5ERWES03wsG/lIuTWztuGj7Me0hjfODTBNetg5UIUBzwKRJmVdXk6/DU
	QLzw==
X-Gm-Message-State: APjAAAUmOLmBvuwTAez9rQy8o+4/ruNcB1Mv0biMBi6o3VgWo2ZsXpCH
	3AUtEYGEpZdEswJAGq/Gcr2FeQ==
X-Google-Smtp-Source: APXvYqxYzZy8GY/dH4++ulBqMjOZ+eAp+O+p7QamjiVEJcLK5ZjpBYUCIQg3RTAriMJkMKHnoI/wAw==
X-Received: by 2002:a1f:ff17:: with SMTP id p23mr3910123vki.62.1560178464373; 
	Mon, 10 Jun 2019 07:54:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206])
	by smtp.gmail.com with ESMTPSA id z10sm983720vsn.23.2019.06.10.07.54.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 10 Jun 2019 07:54:23 -0700 (PDT)
Message-ID: <1560178459.6132.66.camel@lca.pw>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series
	breaks megaraid_sas
From: Qian Cai <cai@lca.pw>
To: Lu Baolu <baolu.lu@linux.intel.com>
Date: Mon, 10 Jun 2019 10:54:19 -0400
In-Reply-To: <1560174264.6132.65.camel@lca.pw>
References: <1559941717.6132.63.camel@lca.pw>
	<1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
	<1560174264.6132.65.camel@lca.pw>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>, iommu@lists.linux-foundation.org
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

On Mon, 2019-06-10 at 09:44 -0400, Qian Cai wrote:
> On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
> > Hi Qian,
> > 
> > I just posted some fix patches. I cc'ed them in your email inbox as
> > well. Can you please check whether they happen to fix your issue?
> > If not, do you mind posting more debug messages?
> 
> Unfortunately, it does not work. Here is the dmesg.
> 
> https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUM
> FUQKLW4ZC47ZPIK

This one should be good to view.

https://cailca.github.io/files/dmesg.txt
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
