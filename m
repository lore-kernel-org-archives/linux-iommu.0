Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B230EC76194
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B275229F3
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+5aYuGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B275229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A3C0DD2;
	Thu, 25 Jul 2019 17:35:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0AC7D99
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 17:35:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6B107224
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 17:35:54 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id s1so17078319pgr.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Tnaeq0Y3gkRSznLM6wB5JlAIZ9EuxGX/RgrHx+lQ6GU=;
	b=C+5aYuGN+LuL47FHCQgQ9iMOaKrQPwI6rEsMqVIxiLRCFl0kcnZ69GnOd+kfP+3l/4
	NMb0HnaCFhUke7ZRA8n8Z0DCNmrjLMoGxxCqmbIwNuIV0ruFj/VzEPzf1NxzCK7O0O/1
	WwxUoiojsmZ35+KD2hXhb20xaKkY5xMReRfSlsK060VHSPiRJjQNeU0qIF4ti/MYIiXl
	TVTBQMIxdpAY9/Ovwh1DGI07f48+LwYAf7s17RpCoY2bgEOG6JiF1f1mt4xb3JiH+TIs
	QITDNjyjPq5oIcqvi7vBU1qOv+Woc3yaux5G3GVaKl8i1XTSaLP1H0Kw6ycxoL4ekXbb
	2IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Tnaeq0Y3gkRSznLM6wB5JlAIZ9EuxGX/RgrHx+lQ6GU=;
	b=lRbrG36Rn51EhcT2NPNQRdsnDSsPVEBBoYXBwKMuXbBec4be9HX5hOELn+td//+j2Y
	/+V6qWdSgmYCNzy+C+iXMIDLSdnFkQ6q7lX3bse5XY3LKqj51m+nkcb3sDOCQcGz+L2j
	jrg8EbiPwMecp8Y85G2lfHU7EqZJnLOKKgKdlsfM/WY3cRLr6QZvv/lUaUYQLGISaLqR
	th5LToI2Z+gQThSWiDZ4o/OrDlWQAD1zzmXGQ4xRJzHv1rXi93qp/kwJ0Wl7InJckH3j
	wHy4SD3l7+4Xh4pVijVWJrBzD5/jQotn9ipDqgWP85HoM5aD2KlM0G+uDlPSjBESTgAt
	Julg==
X-Gm-Message-State: APjAAAUC29EHvcYjOWtY1larBGCqtP7axB2WQbDxd4u+SeZLPXCKaZMH
	tYYjQXUVHt8X7rBZ5s0LxUM=
X-Google-Smtp-Source: APXvYqwe+yUchsfysKmX+u+rwDIkY25DbaaG/Uj2Zbrvveshs2+AdWjHxuGcXkR4lEW/BnFn30cwhQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr61150026pgv.315.1564076153804;
	Thu, 25 Jul 2019 10:35:53 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	z4sm78975766pfg.166.2019.07.25.10.35.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Jul 2019 10:35:53 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:36:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: Fix calculation overflow in __finalise_sg()
Message-ID: <20190725173637.GC31961@Asurada-Nvidia.nvidia.com>
References: <20190622043814.5003-1-nicoleotsuka@gmail.com>
	<20190701122158.GE8166@8bytes.org>
	<91a389be-fd76-c87f-7613-8cc972b69685@arm.com>
	<20190701215016.GA16247@Asurada-Nvidia.nvidia.com>
	<d4bccb17-2f7a-65e4-6c89-e37cceb6d935@arm.com>
	<20190702210400.GA14593@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190702210400.GA14593@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Sorry to ping this but it's been a while.

Robin, did you get a chance to resend your version?

Thanks
Nicolin

On Tue, Jul 02, 2019 at 02:04:01PM -0700, Nicolin Chen wrote:
> On Tue, Jul 02, 2019 at 11:40:02AM +0100, Robin Murphy wrote:
> > On reflection, I don't really think that size_t fits here anyway, since
> > all the members of the incoming struct scatterlist are unsigned int too.
> > Does the patch below work?
> 
> Yes.
> 
> > ----->8-----
> > From: Robin Murphy <robin.murphy@arm.com>
> > Subject: [PATCH] iommu/dma: Handle SG length overflow better
> > 
> > Since scatterlist dimensions are all unsigned ints, in the relatively
> > rare cases where a device's max_segment_size is set to UINT_MAX, then
> > the "cur_len + s_length <= max_len" check in __finalise_sg() will always
> > return true. As a result, the corner case of such a device mapping an
> > excessively large scatterlist which is mergeable to or beyond a total
> > length of 4GB can lead to overflow and a bogus truncated dma_length in
> > the resulting segment.
> > 
> > As we already assume that any single segment must be no longer than
> > max_len to begin with, this can easily be addressed by reshuffling the
> > comparison.
> > 
> > Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> > Reported-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Thank you!
> 
> > ---
> >  drivers/iommu/dma-iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 129c4badf9ae..8de6cf623362 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -721,7 +721,7 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		 * - and wouldn't make the resulting output segment too long
> >  		 */
> >  		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > -		    (cur_len + s_length <= max_len)) {
> > +		    (max_len - cur_len >= s_length)) {
> >  			/* ...then concatenate it with the previous one */
> >  			cur_len += s_length;
> >  		} else {
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
