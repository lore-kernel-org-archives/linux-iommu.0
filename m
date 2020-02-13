Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19072C3B189
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 13:01:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40EF24650
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 13:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdaYpEbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40EF24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A7A6720411;
	Thu, 13 Feb 2020 13:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Lwm81ux4nwP; Thu, 13 Feb 2020 13:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3B1A120358;
	Thu, 13 Feb 2020 13:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA17C07FE;
	Thu, 13 Feb 2020 13:01:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69D82C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 13:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5A4F286CF9
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 13:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sp2HdtiPY-XZ for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 13:00:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9E1D86C02
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 13:00:59 +0000 (UTC)
Received: from localhost (unknown [209.37.97.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 756A22168B;
 Thu, 13 Feb 2020 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581598859;
 bh=twEumPvnyw2Pl8YhKty+VCE7JIjeaqEqyiFe8s6/Jiw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rdaYpEblbV5tf4L5crHu8c9hTW6RG99Pj+wh/ptP2xU3F5rsjtOaLgHAkzCOD3elZ
 wVOieW3iowVEUn4ShEkxHTU/BkwBokzRkVY8HJOvjcvmMm40xSUpiZVVBKck0Cupsi
 aOQpXMPk0690MiFckldJ7NjYe7UEVf7uLnYcNjRU=
Date: Thu, 13 Feb 2020 05:00:59 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
Message-ID: <20200213130059.GA3361459@kroah.com>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200210233711.GA1787983@kroah.com>
 <20200213091509.v7ebvtot6rvlpfjt@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200213091509.v7ebvtot6rvlpfjt@gondor.apana.org.au>
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 kenneth-lee-2012@foxmail.com, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, linux-crypto@vger.kernel.org
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

On Thu, Feb 13, 2020 at 05:15:10PM +0800, Herbert Xu wrote:
> On Mon, Feb 10, 2020 at 03:37:11PM -0800, Greg Kroah-Hartman wrote:
> >
> > Looks much saner now, thanks for all of the work on this:
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Or am I supposed to take this in my tree?  If so, I can, but I need an
> > ack for the crypto parts.
> 
> I can take this series through the crypto tree if that's fine with
> you.

Please do, thanks!

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
