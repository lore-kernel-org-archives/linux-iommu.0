Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5EC468C1
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 13:44:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02ED20859
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gbzpln5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02ED20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 96415C58;
	Mon, 10 Jun 2019 13:44:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3BB82265
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 13:44:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
	[209.85.160.177])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C433976F
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 13:44:27 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id n11so8476870qtl.5
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8GlOa5AWYuEy0cWvebNNXvbMhWK/SQlKTGvJR13KtDA=;
	b=gbzpln5zVB/PmXT2iLPA2ElaWr7aWY2nH1tfDMLxhJfyFw308Aows7Vkwh6+ziHcF2
	kmLhlxUIPq+R5xUr6Y1HWkLjOD6d1jRhEpK/2YPPYdoAFTCQjXbtiUuMVg0ZaeVucMic
	tk64cfUrhw2NNp0bl71PHE+ENt4l1UmK6NbMBIOz+FoISsdZheM7E1rsVv78/JZSQ6C6
	MEB5+/LhkEzAmY/G8xpKM0EU3VoY+Sncc2/rJlgzyeRhG3GWUuSJ1IWPxmuEAFCcngSi
	BGb2O4tqn1tRSh7QaRiuBYCafjDEHWEIum7HyVQW0ZZy7xhZDIP3M0xb+0ls4tgxj1Po
	6gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8GlOa5AWYuEy0cWvebNNXvbMhWK/SQlKTGvJR13KtDA=;
	b=LhoFzgvLBE6HP6Y0fTEGPfkW4djBl4FjRYdrTpydReSId9JTIedR5rhzJJC2oTt0y4
	9jtDf6dApF+vRsafglFC/iD69kDUlqlQOZfvOtS+TF05qrWFfXaXihtp8N4F4xsQ8lBk
	V/cboPOa36o0QpFRPFJHWB+Bzdgkdju1yrSg3x2syZngPkjs1J6eZSC3IgdpMMeFnDDl
	K4r6HP381dU9YHu3i/QtfLF5b9c8rGVoCeUf1GFP/MFsTtEIAuPEsT3C6DUUClDL+bkq
	lx7lcVR/8MEuCbJ10O6kUutKyAMbZDCVi/NMnNW7gZjwIp2ZGI8CAPNu4iq2spuwmWWD
	6GHw==
X-Gm-Message-State: APjAAAVqLTM0LSOul0GDexi3uA3WWOLjbALPlel4RJVqcLe9UJ2qDPbV
	M5K29jRxo9Et2pHL9UopGuvyHg==
X-Google-Smtp-Source: APXvYqzsCSsuUTOm+LNiBGW6RDxOvX0evmGXIygd9Tj5u7Y3Eee+b96fQyqmG3L8e4oFYbo6YbCzCg==
X-Received: by 2002:ac8:595:: with SMTP id a21mr33144837qth.257.1560174266903; 
	Mon, 10 Jun 2019 06:44:26 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	q56sm2634272qtq.64.2019.06.10.06.44.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 10 Jun 2019 06:44:26 -0700 (PDT)
Message-ID: <1560174264.6132.65.camel@lca.pw>
Subject: Re: "iommu/vt-d: Delegate DMA domain to generic iommu" series
	breaks megaraid_sas
From: Qian Cai <cai@lca.pw>
To: Lu Baolu <baolu.lu@linux.intel.com>
Date: Mon, 10 Jun 2019 09:44:24 -0400
In-Reply-To: <1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
References: <1559941717.6132.63.camel@lca.pw>
	<1e4f0642-e4e1-7602-3f50-37edc84ced50@linux.intel.com>
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

On Sun, 2019-06-09 at 10:43 +0800, Lu Baolu wrote:
> Hi Qian,
> 
> I just posted some fix patches. I cc'ed them in your email inbox as
> well. Can you please check whether they happen to fix your issue?
> If not, do you mind posting more debug messages?

Unfortunately, it does not work. Here is the dmesg.

https://raw.githubusercontent.com/cailca/tmp/master/dmesg?token=AMC35QKPIZBYUMFU
QKLW4ZC47ZPIK

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
