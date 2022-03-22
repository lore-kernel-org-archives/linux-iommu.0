Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EBBC433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 14:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AC54813D4;
	Tue, 22 Mar 2022 14:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3h_0bt6aesU9; Tue, 22 Mar 2022 14:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EA2CC813A6;
	Tue, 22 Mar 2022 14:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB917C001A;
	Tue, 22 Mar 2022 14:28:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C8ACC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 14:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5EDE740179
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 14:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ibm.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JHt9Ux_ixqhT for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:28:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26A164000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 14:28:38 +0000 (UTC)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MCNC6c015818; 
 Tue, 22 Mar 2022 14:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Z11ip5jrLOij8BXLnCPgbTlxu3V4V2bH59QABl1feLg=;
 b=BczGLBtEMxnowfT8fLOgC1GFwTyCE/2HfKvumu6qJLy8/qhSr58Xv/NV1gDqqGD7wqfH
 yqnrXGSHgknAZty02m9eyuTGjUhN9WIEu+OHItaqjgUY4/Kpds+UbKra3KuN7l45+3KX
 qwesFXxcS/QcDiDC+znU/AfluG2pfgxbwCEv73crkmiJi5HS5SFyDRF02hQrV+/17PpU
 QcZs6O2904T/FCCI/in2lQ7m92LEh2CUBWeaTcrLF2kMD2nGTsfGfBdw06N9Roa2uWnd
 lVwoz2lSGWvCt7LSGgYncKixjkHN4fMCB/0AQr7G2peUyG2hv2rN4NpBtAQH9VwDqO2w 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ey86uucc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Mar 2022 14:28:29 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22MDPw2E015728;
 Tue, 22 Mar 2022 14:28:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3ey86uucbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Mar 2022 14:28:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22MEHoxM028025;
 Tue, 22 Mar 2022 14:28:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma02fra.de.ibm.com with ESMTP id 3ew6t8ngak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Mar 2022 14:28:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 22MESNIX25821494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Mar 2022 14:28:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC18DA4059;
 Tue, 22 Mar 2022 14:28:23 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AFA8A4040;
 Tue, 22 Mar 2022 14:28:22 +0000 (GMT)
Received: from sig-9-145-28-179.uk.ibm.com (unknown [9.145.28.179])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 22 Mar 2022 14:28:22 +0000 (GMT)
Message-ID: <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Date: Tue, 22 Mar 2022 15:28:22 +0100
In-Reply-To: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZmEmteEVUeELimln3m8Svl5vaJY_h_ne
X-Proofpoint-ORIG-GUID: 2jgrEHbOtCoiWH372ljhi9hP5boIxdqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_04,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220082
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, 2022-03-18 at 14:27 -0300, Jason Gunthorpe wrote:
> Following the pattern of io_uring, perf, skb, and bpf iommfd will use
                                                iommufd ----^
> user->locked_vm for accounting pinned pages. Ensure the value is included
> in the struct and export free_uid() as iommufd is modular.
> 
> user->locked_vm is the correct accounting to use for ulimit because it is
> per-user, and the ulimit is not supposed to be per-process. Other
> places (vfio, vdpa and infiniband) have used mm->pinned_vm and/or
> mm->locked_vm for accounting pinned pages, but this is only per-process
> and inconsistent with the majority of the kernel.

Since this will replace parts of vfio this difference seems
significant. Can you explain this a bit more?

I'm also a bit confused how io_uring handles this. When I stumbled over
the problem fixed by 6b7898eb180d ("io_uring: fix imbalanced sqo_mm
accounting") and from that commit description I seem to rember that
io_uring also accounts in mm->locked_vm too? In fact I stumbled over
that because the wrong accounting in io_uring exhausted the applied to
vfio (I was using a QEMU utilizing io_uring itself).

> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/linux/sched/user.h | 2 +-
>  kernel/user.c              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index 00ed419dd46413..c47dae71dad3c8 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -24,7 +24,7 @@ struct user_struct {
>  	kuid_t uid;
>  
>  #if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
> -    defined(CONFIG_NET) || defined(CONFIG_IO_URING)
> +    defined(CONFIG_NET) || defined(CONFIG_IO_URING) || IS_ENABLED(CONFIG_IOMMUFD)
>  	atomic_long_t locked_vm;
>  #endif
>  #ifdef CONFIG_WATCH_QUEUE
> diff --git a/kernel/user.c b/kernel/user.c
> index e2cf8c22b539a7..d667debeafd609 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -185,6 +185,7 @@ void free_uid(struct user_struct *up)
>  	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
>  		free_user(up, flags);
>  }
> +EXPORT_SYMBOL_GPL(free_uid);
>  
>  struct user_struct *alloc_uid(kuid_t uid)
>  {


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
