Return-Path: <SRS0=rccM=VJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B7C742D7
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 18:40:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE132146E
	for <iommu@archiver.kernel.org>; Fri, 12 Jul 2019 18:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewlHia7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE132146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F1C016639;
	Fri, 12 Jul 2019 18:40:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 57EEF662F
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 18:31:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
	[209.85.221.175])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AD1E8886
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 18:31:08 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id b69so2281396vkb.3
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Jul 2019 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=cIV6rBtWLOPRszoGLvj5E27EPDYcnDtLD4/tbfFhpvo=;
	b=ewlHia7heeXX9gEvyayde5mx7+AEFE0O5WkRam9jXzXTM/cF4Rro/laOPuQDFADMkT
	pgBCEH82Sq2vQ5ytflI6aY9ECob3kCsDLkBEomA3BoZout9U7Tkh8v3UE+GqetFYgZwv
	T9i5nUr03L9NNnlgh1av/pQ5TwsQVLAfpkfba/uE0+COO/CT7rM4kTujCxnHZ/jfmRvl
	Ha6cWu/ktyCI4B3Ir3wy+Td4QeX9+knTOY4KmhVoy866xKmqHKB7yJFGampkVPjO1EH4
	syIDycrhKY/v7I3cqPWeNoNwRIu14RMQ2H5DNvB4fr8fphQAmDKq04wf+IpE1qy8dZZV
	aODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=cIV6rBtWLOPRszoGLvj5E27EPDYcnDtLD4/tbfFhpvo=;
	b=uBN0ahy7EEWA9HjFQaBYa8QTz1ewi4rj6fSRJT6P5e5LnwKpDd6XHin/QzyKDJp/Sj
	vYvD3RHJtEdBVNUJ8+SxynvNMmSABlFgctrYOBpOdXmNU9Xyt6Hk2suC/bXWDAwGqg9m
	o8QSig0GqRVeuulw2SQNBmwUrDf541N7xUVQ47PaXXu3H7UciELmx9HGwUc94SqjP2M7
	9b2ld2wTpsZbEnA8gjEwGXy+qBYPiHz9jjUXx8Nxrf7fI1sshWvXqj7K6LGNC6w+Prj7
	615XNLve9uMabZBC1e0rVGg2hqjq9yl4SRQFO21uH/RBT/Gp5TbtbxBBwblivtJVUZym
	paBQ==
X-Gm-Message-State: APjAAAWTrNuxY4+yXiNorRoWdnDMgf1shxE6qwQlnfcAevcFqQBw0kli
	o5GLRrwVzaXENo5XCsfIBzPfsO6wRuSeqrnqu70=
X-Google-Smtp-Source: APXvYqwoOrs4KeF1E3Iz5G6XucPUIl+s2QlAoOR993+Fq0+SJIKbbL4lgPIPTE2VQvtDIDsJPH41GoubeuVBEnQGkuo=
X-Received: by 2002:a1f:62c3:: with SMTP id w186mr6618726vkb.82.1562956267589; 
	Fri, 12 Jul 2019 11:31:07 -0700 (PDT)
MIME-Version: 1.0
From: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date: Sat, 13 Jul 2019 00:00:56 +0530
Message-ID: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
Subject: cma_remap when using dma_alloc_attr :- DMA_ATTR_NO_KERNEL_MAPPING
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>, 
	Robin Murphy <robin.murphy@arm.com>, Michal Hocko <mhocko@kernel.org>, 
	pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
	minchan.kim@gmail.com
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
Content-Type: multipart/mixed; boundary="===============4333674490347965475=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

--===============4333674490347965475==
Content-Type: multipart/alternative; boundary="0000000000002114d7058d801d4a"

--0000000000002114d7058d801d4a
Content-Type: text/plain; charset="UTF-8"

Hello,

When we allocate cma memory using dma_alloc_attr using
DMA_ATTR_NO_KERNEL_MAPPING attribute. It will return physical address
without virtual mapping and thats the use case of this attribute. but lets
say some vpu/gpu drivers required virtual mapping of some part of the
allocation. then we dont have anything to remap that allocated memory to
virtual memory. and in 32-bit system it difficult for devices like android
to work all the time with virtual mapping, it degrade the performance.

For Example :

Lets say 4k video allocation required 300MB cma memory but not required
virtual mapping for all the 300MB, its require only 20MB virtually mapped
at some specific use case/point of video, and unmap virtual mapping after
uses, at that time this functions will be useful, it works like ioremap()
for cma_alloc() using dma apis.

/*
         * function call(s) to create virtual map of given physical memory
         * range [base, base+size) of CMA memory.
*/
void *cma_remap(__u32 base, __u32 size)
{
        struct page *page = phys_to_page(base);
        void *virt;

        pr_debug("cma: request to map 0x%08x for size 0x%08x\n",
                        base, size);

        size = PAGE_ALIGN(size);

        pgprot_t prot = get_dma_pgprot(DMA_ATTR, PAGE_KERNEL);

        if (PageHighMem(page)){
                virt = dma_alloc_remap(page, size, GFP_KERNEL, prot,
__builtin_return_address(0));
        }
        else
        {
                dma_remap(page, size, prot);
                virt = page_address(page);
        }

        if (!virt)
                pr_err("\x1b[31m" " cma: failed to map 0x%08x" "\x1b[0m\n",
                                base);
        else
                pr_debug("cma: 0x%08x is virtually mapped to 0x%08x\n",
                                base, (__u32) virt);

        return virt;
}

/*
         * function call(s) to remove virtual map of given virtual memory
         * range [virt, virt+size) of CMA memory.
*/

void cma_unmap(void *virt, __u32 size)
{
        size = PAGE_ALIGN(size);
        unsigned long pfn = virt_to_pfn(virt);
        struct page *page = pfn_to_page(pfn);

                if (PageHighMem(page))
                        dma_free_remap(virt, size);
                else
                        dma_remap(page, size, PAGE_KERNEL);

        pr_debug(" cma: virtual address 0x%08x is unmapped\n",
                        (__u32) virt);
}

This functions should be added in arch/arm/mm/dma-mapping.c file.

Please let me know if i am missing anything.

Regards,
Pankaj

--0000000000002114d7058d801d4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>When we allocate cma memory using dma_alloc_=
attr using DMA_ATTR_NO_KERNEL_MAPPING attribute. It will return physical ad=
dress without virtual mapping and thats the use case of this attribute. but=
 lets say some vpu/gpu drivers required virtual mapping of some part of the=
 allocation. then we dont have anything to remap that allocated memory to v=
irtual memory. and in 32-bit system it difficult for devices like android t=
o work all the time with virtual mapping, it degrade the performance.<br><b=
r>For Example :<br><br>Lets say 4k video allocation required 300MB cma memo=
ry but not required virtual mapping for all the 300MB, its require only 20M=
B virtually mapped at some specific use case/point of video, and unmap virt=
ual mapping after uses, at that time this functions will be useful, it work=
s like ioremap() for cma_alloc() using dma apis.<br><br>/*<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* function call(s) to create virtual map of given phys=
ical memory<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* range [base, base+size) =
of CMA memory.<br>*/<br>void *cma_remap(__u32 base, __u32 size)<br>{<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct page *page =3D phys_to_page(base);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *virt;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_=
debug(&quot;cma: request to map 0x%08x for size 0x%08x\n&quot;,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 base, size);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D PAGE_ALIGN(siz=
e);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pgprot_t prot =3D get_dma_pgprot(DMA=
_ATTR, PAGE_KERNEL);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PageHighMem(pag=
e)){<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt =3D dm=
a_alloc_remap(page, size, GFP_KERNEL, prot, __builtin_return_address(0));<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dma_remap(page, size, prot);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 virt =3D page_address(page);<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virt)<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(&quot;\x1b[31m&quot; &quo=
t; cma: failed to map 0x%08x&quot; &quot;\x1b[0m\n&quot;,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 base);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug(&quot;cma: 0x=
%08x is virtually mapped to 0x%08x\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 base, (__u32) virt);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return v=
irt;<br>}<br><br>/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* function call(s)=
 to remove virtual map of given virtual memory<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* range [virt, virt+size) of CMA memory.<br>*/<br><br>void cma_un=
map(void *virt, __u32 size)<br>{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 size =3D PA=
GE_ALIGN(size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long pfn =3D virt_t=
o_pfn(virt);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct page *page =3D pfn_to_pa=
ge(pfn);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(PageHighMem(page))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_free_remap(virt, size);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_remap(pa=
ge, size, PAGE_KERNEL);<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug(&quot; =
cma: virtual address 0x%08x is unmapped\n&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (__u32) virt=
);<br>}<br><br><div>This functions should be added in arch/arm/mm/dma-mappi=
ng.c file.</div><div><br></div><div>Please let me know if i am missing anyt=
hing.</div><div><br></div><div>Regards,</div><div>Pankaj<br></div></div>

--0000000000002114d7058d801d4a--

--===============4333674490347965475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4333674490347965475==--
