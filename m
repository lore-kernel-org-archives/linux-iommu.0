Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF64FC010C9
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 11:48:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA9821D71
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 11:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL6TiWTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA9821D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 411941085;
	Tue,  5 Nov 2019 11:48:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA317EC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 11:48:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9985A189
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 11:48:49 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x4so9387595wmi.3
	for <iommu@lists.linux-foundation.org>;
	Tue, 05 Nov 2019 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=zp9qiL0ltKb9jL4LVJWEei4ILz8NVBXvn672HPv3XcE=;
	b=NL6TiWTvdinGYZluWGSsmZHNFr526R7MSyzrU5joAq8uK73VAEVt5GLJ6QYKHk4ABF
	uQtRxl4A9S7biM/riwE1QQAKdMrUtyFjUg0NW55RuQMaaLUumpiq2aT07Gi2egGFx6iy
	QepJirNZwiury2KpZ/d0E8bDtTNh/kDADtHeAmXhMbTglW2MBjbE69TphKWtv6Eh6nlZ
	wiSCSdNBNDhFQEd04RYxnwg5IvY/cr8npLB7x9fv7+M1Nv6NWgXyf3DP/n86+XKX4g52
	aCFvzWysEiEzr0Ae7XfHHE5aeFspdoalu9yj8/vHZDsUWJIZZMh4u/WkFTRrU/s9Nmyh
	606A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=zp9qiL0ltKb9jL4LVJWEei4ILz8NVBXvn672HPv3XcE=;
	b=YR78F61BWbPWZleCjPhgWn0u5K2GIL10oO/bngQOxOd9KTlQtBs1kJ4cK60UrTMCcF
	EkoW39gPxearfmhTYtUAL+uoOWnatKXNY0sBy7SZMUrNwchTkUvprCLebGC3t18v0+gZ
	zfHKlfDqKywydx6gmDA9CL6/f1dRdOqLK+tSwZBtnRfekUMn68oATMhhPyASAWsmAUVZ
	o/9yH+5BF+rSQycE8WCdAbCnHVkCoJm/qVw72mvARwQNoA5mW2zkTPmI+xMpaHAYyeis
	mutj6IV+26Mz+FCGCOU8icMWQC+g8htcIvxpSNHqms2uvyafgrFl80RYzypuHXimOPUh
	CSWA==
X-Gm-Message-State: APjAAAXXzimVcTjr6WqXeQAFEqPdCiaaKd+iMH64UifuRUpmCSwQIgbQ
	iFmXRanazgzOMIR1af2k+EIXdA==
X-Google-Smtp-Source: APXvYqwzbVrprBjq+eXGIRVB0swnwWh7fhMwzUoJE509CMdkS7DkewOthPh20OJBQh8PWTIGQh1OIw==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr1768915wmk.128.1572954528016; 
	Tue, 05 Nov 2019 03:48:48 -0800 (PST)
Received: from lophozonia ([85.195.192.192]) by smtp.gmail.com with ESMTPSA id
	f13sm19986974wrq.96.2019.11.05.03.48.46
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 05 Nov 2019 03:48:47 -0800 (PST)
Date: Tue, 5 Nov 2019 12:48:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v7 2/3] uacce: add uacce driver
Message-ID: <20191105114844.GA3648434@lophozonia>
References: <1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org>
	<1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572331216-9503-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: francois.ozog@linaro.org, Herbert Xu <herbert@gondor.apana.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
	grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
	linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
	Kenneth Lee <liguozhu@hisilicon.com>, guodong.xu@linaro.org,
	kenneth-lee-2012@foxmail.com
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

Hi Zhangfei,

Thanks for simplifying this, it's a lot easier to review. I have some
additional comments.

On Tue, Oct 29, 2019 at 02:40:15PM +0800, Zhangfei Gao wrote:
> +static int uacce_sva_exit(struct device *dev, struct iommu_sva *handle,
> +			  void *data)
> +{
> +	struct uacce_device *uacce = data;
> +	struct uacce_queue *q;
> +
> +	mutex_lock(&uacce->q_lock);
> +	list_for_each_entry(q, &uacce->qs, list) {
> +		if (q->pid == task_pid_nr(current))
> +			uacce_put_queue(q);

This won't work in some cases, because any thread can call __mmput() and
end up here. For example a sibling thread that inherited the queue, or a
workqueue that's executing mmput_async_fn(). In addition I think comparing
PID values is unsafe (see comment in pid.h), we'd need to use the struct
pid if we wanted to do it this way.

But I still believe it would be better to create an uacce_mm structure
that tracks all queues bound to this mm, and pass that to uacce_sva_exit
instead of the uacce_device.

The queue isn't bound to a task, but its address space. With clone() the
address space can be shared between tasks. In addition, whoever has a
queue fd also gets access to this address space. So after a fork() the
child may be able to program the queue to DMA into the parent's address
space, even without CLONE_VM. Users must be aware of this and I think it's
important to explain it very clearly in the UAPI.

[...]
> +static struct uacce_qfile_region *
> +uacce_create_region(struct uacce_queue *q, struct vm_area_struct *vma,
> +		    enum uacce_qfrt type, unsigned int flags)
> +{
> +	struct uacce_device *uacce = q->uacce;
> +	struct uacce_qfile_region *qfr;
> +	int ret = -ENOMEM;
> +
> +	qfr = kzalloc(sizeof(*qfr), GFP_KERNEL);
> +	if (!qfr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	qfr->type = type;
> +	qfr->flags = flags;
> +
> +	if (vma->vm_flags & VM_READ)
> +		qfr->prot |= IOMMU_READ;

qfr->prot and qfr->flags aren't used at the moment, you could remove them.

> +
> +	if (vma->vm_flags & VM_WRITE)
> +		qfr->prot |= IOMMU_WRITE;
> +
> +	if (flags & UACCE_QFRF_SELFMT) {
> +		if (!uacce->ops->mmap) {
> +			ret = -EINVAL;
> +			goto err_with_qfr;
> +		}
> +
> +		ret = uacce->ops->mmap(q, vma, qfr);
> +		if (ret)
> +			goto err_with_qfr;
> +		return qfr;
> +	}
> +
> +	return qfr;
> +
> +err_with_qfr:
> +	kfree(qfr);
> +	return ERR_PTR(ret);
> +}
> +
> +static int uacce_fops_mmap(struct file *filep, struct vm_area_struct *vma)
> +{
> +	struct uacce_queue *q = filep->private_data;
> +	struct uacce_device *uacce = q->uacce;
> +	struct uacce_qfile_region *qfr;
> +	enum uacce_qfrt type = 0;
> +	unsigned int flags = 0;
> +	int ret;
> +
> +	if (vma->vm_pgoff < UACCE_QFRT_MAX)
> +		type = vma->vm_pgoff;

Otherwise return -EINVAL?  type probably shouldn't default to MMIO if it
wasn't explicitly requested by the user.

> +
> +	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_WIPEONFORK;
> +	vma->vm_ops = &uacce_vm_ops;
> +	vma->vm_private_data = q;
> +
> +	mutex_lock(&uacce_mutex);
> +
> +	if (q->qfrs[type]) {
> +		ret = -EEXIST;
> +		goto out_with_lock;
> +	}
> +
> +	switch (type) {
> +	case UACCE_QFRT_MMIO:
> +		flags = UACCE_QFRF_SELFMT;
> +		break;
> +
> +	case UACCE_QFRT_DUS:
> +		if (uacce->flags & UACCE_DEV_SVA) {
> +			flags = UACCE_QFRF_SELFMT;

I'd simplify this even further by getting rid of the SELFMT flag. It's the
only possibility at the moment.

> +			break;
> +		}
> +		break;
> +
> +	default:
> +		WARN_ON(&uacce->dev);

WARN_ON(uacce->dev). But shouldn't we instead return -EINVAL here?
UACCE_QFRT_MAX is currently 16, so users can easily trigger this WARN by
passing an invalid value.

[...]
> +void uacce_unregister(struct uacce_device *uacce)
> +{
> +	if (!uacce)
> +		return;
> +
> +	mutex_lock(&uacce->q_lock);
> +	if (!list_empty(&uacce->qs)) {
> +		struct uacce_queue *q;
> +
> +		list_for_each_entry(q, &uacce->qs, list) {
> +			uacce_put_queue(q);

The open file descriptor will still exist after this function returns.
Can all fops can be called with a stale queue?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
