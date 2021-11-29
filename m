Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D75C433FE
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 08:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 703C340194;
	Mon, 29 Nov 2021 08:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQr8n_MbqJfn; Mon, 29 Nov 2021 08:37:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 21CC04015E;
	Mon, 29 Nov 2021 08:37:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00596C001C;
	Mon, 29 Nov 2021 08:37:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0BEFC000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA1874015E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RTGvQhq9bw9 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 08:37:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEC9E400BC
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 08:37:53 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 n17-20020a9d64d1000000b00579cf677301so24502323otl.8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7a5MxLKVIzSHGMLo+vbhEaGS6kMj3rpGZkCW++mhnDY=;
 b=DtxWMBh3rfzVIhnUsqjOrn7tSfgOpwlM0H/QoZCipAE7almTxNgJnmGVANXWOOhv7L
 Cxh0c2VY7MdYlrtBKYSkp2Va36yZq/7FDsw+TrQ17BmHqaHT8a2L2DBCKYPH4gY/FBgy
 KKTqL9JWxd5g7jbA28GmuZmdgsPDKEW8KqYzotfcQ/XnjjHIngz4NkrPdcyK5LT9U5IW
 P26emPPojfJT2o8dagJcL79kH/0C6qEW29w0TkFjpN7mvZdNXky5LWcd4k2PQucSAi0i
 QCum736/X1PnnC0jMzBjHz7h5TrB9gtU++6xZNKJG4keYsL8C5BO1e4in/jPFAn+NH47
 opAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7a5MxLKVIzSHGMLo+vbhEaGS6kMj3rpGZkCW++mhnDY=;
 b=cxyyMGxF5WS77oGeLITE/w5Rk7Mba6pwPeNxJnGS0eFmwPmYor45vIxOTBufqR/LH3
 T1OD74DGI94YVqRsEF80+xUjeIDOtBYZhaxfPldCvesfScNFMDy8jA1wpY1xF0OO2zEJ
 qFGKJsa/1GDnROVRafLzDCg8mQbmFks1zlXjxz4KM1UGMskbjvmHbuGOxsb1+jlSkXoF
 ZW0b1F6SsksY5UBhviJt+aYmC6V9bMPicn0NH3yMJbgA6IgqUmUY2TNPDJHOyz13Qjde
 xW/3200xMeKDK7hZCTKh2vZl3W04HTytiJRebiAhxIly9Vf8b/iXbVk9NTcUYmQFdSXn
 kjSg==
X-Gm-Message-State: AOAM5317XR/du0/RhyzjTd9xwcHib+7Yfdh2razZIJbY0aSFQLFoDI2T
 02/ph+7/M4QRsu9/yORbfJ30fvWuUCKpsVIxJN0=
X-Google-Smtp-Source: ABdhPJwZ1AnFrHk2A0pC//vhEa9gzuOBwX5I9Eumi3jbcim+FimL/UKjPBEdzZA6tH7J8tSiiKZEDpokZwp5ZmPIySk=
X-Received: by 2002:a9d:6f0e:: with SMTP id n14mr43682380otq.173.1638175072807; 
 Mon, 29 Nov 2021 00:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20211129082948.GA29816@kili>
In-Reply-To: <20211129082948.GA29816@kili>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 29 Nov 2021 14:07:40 +0530
Message-ID: <CAHP4M8Vzhs4Q3a-oAxzNkBX8-f7QyxsfQqPca5dgOWr5chdJBA@mail.gmail.com>
Subject: Re: [bug report] iommu/vt-d: Fix unmap_pages support
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org
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

Hi Dan.

The updated patch has landed in mainline, as per :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=86dc40c7ea9c22f64571e0e45f695de73a0e2644



On Mon, Nov 29, 2021 at 2:00 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Alex Williamson,
>
> The patch edad96db58d2: "iommu/vt-d: Fix unmap_pages support" from
> Nov 22, 2021, leads to the following Smatch static checker warning:
>
>         drivers/iommu/intel/iommu.c:1369 dma_pte_clear_level()
>         error: uninitialized symbol 'level_pfn'.
>
> drivers/iommu/intel/iommu.c
>     1330 static struct page *dma_pte_clear_level(struct dmar_domain *domain, int level,
>     1331                                         struct dma_pte *pte, unsigned long pfn,
>     1332                                         unsigned long start_pfn,
>     1333                                         unsigned long last_pfn,
>     1334                                         struct page *freelist)
>     1335 {
>     1336         struct dma_pte *first_pte = NULL, *last_pte = NULL;
>     1337
>     1338         pfn = max(start_pfn, pfn);
>     1339         pte = &pte[pfn_level_offset(pfn, level)];
>     1340
>     1341         do {
>     1342                 unsigned long level_pfn;
>     1343
>     1344                 if (!dma_pte_present(pte))
>     1345                         goto next;
>                                  ^^^^^^^^^^
>
> If we ever hit this goto then there is going to be a bug.
>
>     1346
>     1347                 level_pfn = pfn & level_mask(level);
>     1348
>     1349                 /* If range covers entire pagetable, free it */
>     1350                 if (start_pfn <= level_pfn &&
>     1351                     last_pfn >= level_pfn + level_size(level) - 1) {
>     1352                         /* These suborbinate page tables are going away entirely. Don't
>     1353                            bother to clear them; we're just going to *free* them. */
>     1354                         if (level > 1 && !dma_pte_superpage(pte))
>     1355                                 freelist = dma_pte_list_pagetables(domain, level - 1, pte, freelist);
>     1356
>     1357                         dma_clear_pte(pte);
>     1358                         if (!first_pte)
>     1359                                 first_pte = pte;
>     1360                         last_pte = pte;
>     1361                 } else if (level > 1) {
>     1362                         /* Recurse down into a level that isn't *entirely* obsolete */
>     1363                         freelist = dma_pte_clear_level(domain, level - 1,
>     1364                                                        phys_to_virt(dma_pte_addr(pte)),
>     1365                                                        level_pfn, start_pfn, last_pfn,
>     1366                                                        freelist);
>     1367                 }
>     1368 next:
> --> 1369                 pfn = level_pfn + level_size(level);
>                                ^^^^^^^^^
>
>     1370         } while (!first_pte_in_page(++pte) && pfn <= last_pfn);
>     1371
>     1372         if (first_pte)
>     1373                 domain_flush_cache(domain, first_pte,
>     1374                                    (void *)++last_pte - (void *)first_pte);
>     1375
>     1376         return freelist;
>     1377 }
>
> regards,
> dan carpenter
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
