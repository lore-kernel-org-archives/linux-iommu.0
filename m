Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E10C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 13:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8C5360DA0;
	Mon, 25 Apr 2022 13:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4rGLBnbRFxq; Mon, 25 Apr 2022 13:54:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D20360A6A;
	Mon, 25 Apr 2022 13:54:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60E02C0039;
	Mon, 25 Apr 2022 13:54:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83182C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 13:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 607DB60AA8
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 13:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdXe1xi12Xjj for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 13:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B11960A6A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 13:54:11 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id k2so536601wrd.5
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ju3MNG0l6PZT3NlPuxMjxhTveM28nyA7MnYp02HrA3g=;
 b=c2XdBLBOlfmLEWkJaYwfFywTyfskFCw6bpnjcfeqXhyBmEqmUQjwPOV4AyIggXagiD
 wzbWZxTpH9r3DOzhbxg/99dGPHgdmS7G6aaQOo6gNeyvelEh9kNT4uPxd9Z3fIJVbjDv
 1fgHdpRRPrpYkpZZ/ehfVQYYOrTkk727CPzkR2PczdmVc0zgqan189Bu3CV6+ledwkUm
 8gnLVa+acEhbE8q59GCjNiopmnkAZhjUwfsAw7wH8xszCr1FVSxY8y+/STArB0DN2OLL
 mD4bmmHVRXPEkOUcwIR5fe4iZhXszr8h0kAleiNz0H98aT9Qq55L3b+WKDDrRLitbGXy
 G1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ju3MNG0l6PZT3NlPuxMjxhTveM28nyA7MnYp02HrA3g=;
 b=tiD89XqBT83mwTurofLpUj/9u3hJVNj/v666ZB7ibfCtm/83CBS3CCg69m4Y304E1T
 p7tw6Ml6Q/R3jXZGfDJMcQQVPDjQ3h46VdaeyDGgwZVTln9dI6T986y1ySyyRC2gJStq
 2+E7aja425yYbVYuJRorGmyW4mIFakzWKIA00TYLlZK+A4a6UuZBkxp4MzU74eDxhL4I
 hSb24mByoHGVeDNeb4WcwuebRD3H6AtcU26J5ULV+JtaQQu4EPuuxmaG7vSaCEsOx6aG
 HUXDtUSUNCGufhEVTC82mviTkFzAnYnxmSXgGQZiJJFrVuXqxgN+0iBU0YZzWXTc28mM
 YzaQ==
X-Gm-Message-State: AOAM5326VrMqtuGC97VImUCrU5XTiZVdH3HBJNQ/a3mJRw8S1TeTtVoi
 cmlfWwGw19KO6mMSDJkXC9rQIg==
X-Google-Smtp-Source: ABdhPJz+1hYJkj+HhnpfpVFJ6D5wdXQQNaTjTH0Nimfg+P2+HGw1UFJpbD4CnfWYJewGKpHqxsVDQg==
X-Received: by 2002:a05:6000:49:b0:20a:da03:951f with SMTP id
 k9-20020a056000004900b0020ada03951fmr4757075wrx.519.1650894849681; 
 Mon, 25 Apr 2022 06:54:09 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 q15-20020adfaa4f000000b0020ac7bd4affsm11029272wrd.0.2022.04.25.06.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 06:54:08 -0700 (PDT)
Date: Mon, 25 Apr 2022 14:53:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Yman5hLomw9/c+bi@myrica>
References: <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
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

On Sat, Apr 23, 2022 at 07:13:39PM +0800, zhangfei.gao@foxmail.com wrote:
> > > On 5.17
> > > fops_release is called automatically, as well as iommu_sva_unbind_device.
> > > On 5.18-rc1.
> > > fops_release is not called, have to manually call close(fd)
> > Right that's weird
> Looks it is caused by the fix patch, via mmget, which may add refcount of
> fd.

Yes indirectly I think: when the process mmaps the queue, mmap_region()
takes a reference to the uacce fd. That reference is released either by
explicit close() or munmap(), or by exit_mmap() (which is triggered by
mmput()). Since there is an mm->fd dependency, we cannot add a fd->mm
dependency, so no mmget()/mmput() in bind()/unbind().

I guess we should go back to refcounted PASIDs instead, to avoid freeing
them until unbind().

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
