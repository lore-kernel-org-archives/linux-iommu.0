Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A3C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 11:10:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6765464DBA
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 11:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6765464DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18C75869A3;
	Thu,  4 Feb 2021 11:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gqZuFt8MHpj3; Thu,  4 Feb 2021 11:10:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92B4B8693D;
	Thu,  4 Feb 2021 11:10:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74D3EC07FD;
	Thu,  4 Feb 2021 11:10:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBD6CC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C193086944
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vuP-u0K4M0RW for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:10:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E62FD8693D
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 11:10:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: gtucker) with ESMTPSA id 4104E1F46060
Subject: Re: [PATCH RESEND v2 4/5] iommu/tegra-smmu: Rework
 tegra_smmu_probe_device()
To: Nicolin Chen <nicoleotsuka@gmail.com>, will@kernel.org
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
 <20201125101013.14953-5-nicoleotsuka@gmail.com>
From: Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <46a96cf9-91cc-2ad4-702a-e95ba7200375@collabora.com>
Date: Thu, 4 Feb 2021 11:10:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201125101013.14953-5-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: kernel@collabora.com,
 "kernelci-results@groups.io" <kernelci-results@groups.io>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, jonathanh@nvidia.com
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

Hi Nicolin,

A regression was detected by kernelci.org in IGT's drm_read tests
on mainline, it was first seen on 17th December 2020.  You can
find some details here:

  https://kernelci.org/test/case/id/600b82dc1e3208f123d3dffc/

Then an automated bisection was run and it landed on this
patch (v5.10-rc3-4-g25938c73cd79 on mainline).  Normally, an
email is generated automatically but I had to start this one by
hand as there were issues getting it to complete.

You can see the failing test cases with this patch:

  https://lava.collabora.co.uk/results/3126405/0_igt-kms-tegra

Some errors are seen around this point in the log:

  https://lava.collabora.co.uk/scheduler/job/3126405#L1005

[    3.029729] tegra-mc 70019000.memory-controller: display0a: read @0xfe000000: EMEM address decode error (SMMU translation error [--S])
[    3.042058] tegra-mc 70019000.memory-controller: display0a: read @0xfe000000: Page fault (SMMU translation error [--S])


Here's the same test passing with this patch reverted:

  https://lava.collabora.co.uk/results/3126570/0_igt-kms-tegra
  

For completeness, you can see all the test jobs run by the
automated bisection here:

  https://lava.collabora.co.uk/scheduler/device_type/tegra124-nyan-big?dt_length=25&dt_search=bisection-gtucker-12#dt_


Please let us know if you need any help debugging this issue or
to try a fix on this platform.

Best wishes,
Guillaume

On 25/11/2020 10:10, Nicolin Chen wrote:
> The bus_set_iommu() in tegra_smmu_probe() enumerates all clients
> to call in tegra_smmu_probe_device() where each client searches
> its DT node for smmu pointer and swgroup ID, so as to configure
> an fwspec. But this requires a valid smmu pointer even before mc
> and smmu drivers are probed. So in tegra_smmu_probe() we added a
> line of code to fill mc->smmu, marking "a bit of a hack".
> 
> This works for most of clients in the DTB, however, doesn't work
> for a client that doesn't exist in DTB, a PCI device for example.
> 
> Actually, if we return ERR_PTR(-ENODEV) in ->probe_device() when
> it's called from bus_set_iommu(), iommu core will let everything
> carry on. Then when a client gets probed, of_iommu_configure() in
> iommu core will search DTB for swgroup ID and call ->of_xlate()
> to prepare an fwspec, similar to tegra_smmu_probe_device() and
> tegra_smmu_configure(). Then it'll call tegra_smmu_probe_device()
> again, and this time we shall return smmu->iommu pointer properly.
> 
> So we can get rid of tegra_smmu_find() and tegra_smmu_configure()
> along with DT polling code by letting the iommu core handle every
> thing, except a problem that we search iommus property in DTB not
> only for swgroup ID but also for mc node to get mc->smmu pointer
> to call dev_iommu_priv_set() and return the smmu->iommu pointer.
> So we'll need to find another way to get smmu pointer.
> 
> Referencing the implementation of sun50i-iommu driver, of_xlate()
> has client's dev pointer, mc node and swgroup ID. This means that
> we can call dev_iommu_priv_set() in of_xlate() instead, so we can
> simply get smmu pointer in ->probe_device().
> 
> This patch reworks tegra_smmu_probe_device() by:
> 1) Removing mc->smmu hack in tegra_smmu_probe() so as to return
>    ERR_PTR(-ENODEV) in tegra_smmu_probe_device() during stage of
>    tegra_smmu_probe/tegra_mc_probe().
> 2) Moving dev_iommu_priv_set() to of_xlate() so we can get smmu
>    pointer in tegra_smmu_probe_device() to replace DTB polling.
> 3) Removing tegra_smmu_configure() accordingly since iommu core
>    takes care of it.
> 
> This also fixes a problem that previously we could add clients to
> iommu groups before iommu core initializes its default domain:
>     ubuntu@jetson:~$ dmesg | grep iommu
>     platform 50000000.host1x: Adding to iommu group 1
>     platform 57000000.gpu: Adding to iommu group 2
>     iommu: Default domain type: Translated
>     platform 54200000.dc: Adding to iommu group 3
>     platform 54240000.dc: Adding to iommu group 3
>     platform 54340000.vic: Adding to iommu group 4
> 
> Though it works fine with IOMMU_DOMAIN_UNMANAGED, but will have
> warnings if switching to IOMMU_DOMAIN_DMA:
>     iommu: Failed to allocate default IOMMU domain of type 0 for
>            group (null) - Falling back to IOMMU_DOMAIN_DMA
>     iommu: Failed to allocate default IOMMU domain of type 0 for
>            group (null) - Falling back to IOMMU_DOMAIN_DMA
> 
> Now, bypassing the first probe_device() call from bus_set_iommu()
> fixes the sequence:
>     ubuntu@jetson:~$ dmesg | grep iommu
>     iommu: Default domain type: Translated
>     tegra-host1x 50000000.host1x: Adding to iommu group 0
>     tegra-dc 54200000.dc: Adding to iommu group 1
>     tegra-dc 54240000.dc: Adding to iommu group 1
>     tegra-vic 54340000.vic: Adding to iommu group 2
>     nouveau 57000000.gpu: Adding to iommu group 3
> 
> Note that dmesg log above is testing with IOMMU_DOMAIN_UNMANAGED.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 96 ++++++--------------------------------
>  1 file changed, 15 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 297d49f3f80e..f45ed43cf8db 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -797,75 +797,9 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
>  	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
>  }
>  
> -static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
> -{
> -	struct platform_device *pdev;
> -	struct tegra_mc *mc;
> -
> -	pdev = of_find_device_by_node(np);
> -	if (!pdev)
> -		return NULL;
> -
> -	mc = platform_get_drvdata(pdev);
> -	if (!mc)
> -		return NULL;
> -
> -	return mc->smmu;
> -}
> -
> -static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
> -				struct of_phandle_args *args)
> -{
> -	const struct iommu_ops *ops = smmu->iommu.ops;
> -	int err;
> -
> -	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> -	if (err < 0) {
> -		dev_err(dev, "failed to initialize fwspec: %d\n", err);
> -		return err;
> -	}
> -
> -	err = ops->of_xlate(dev, args);
> -	if (err < 0) {
> -		dev_err(dev, "failed to parse SW group ID: %d\n", err);
> -		iommu_fwspec_free(dev);
> -		return err;
> -	}
> -
> -	return 0;
> -}
> -
>  static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
>  {
> -	struct device_node *np = dev->of_node;
> -	struct tegra_smmu *smmu = NULL;
> -	struct of_phandle_args args;
> -	unsigned int index = 0;
> -	int err;
> -
> -	while (of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
> -					  &args) == 0) {
> -		smmu = tegra_smmu_find(args.np);
> -		if (smmu) {
> -			err = tegra_smmu_configure(smmu, dev, &args);
> -			of_node_put(args.np);
> -
> -			if (err < 0)
> -				return ERR_PTR(err);
> -
> -			/*
> -			 * Only a single IOMMU master interface is currently
> -			 * supported by the Linux kernel, so abort after the
> -			 * first match.
> -			 */
> -			dev_iommu_priv_set(dev, smmu);
> -
> -			break;
> -		}
> -
> -		of_node_put(args.np);
> -		index++;
> -	}
> +	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
>  
>  	if (!smmu)
>  		return ERR_PTR(-ENODEV);
> @@ -873,10 +807,7 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
>  	return &smmu->iommu;
>  }
>  
> -static void tegra_smmu_release_device(struct device *dev)
> -{
> -	dev_iommu_priv_set(dev, NULL);
> -}
> +static void tegra_smmu_release_device(struct device *dev) {}
>  
>  static const struct tegra_smmu_group_soc *
>  tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
> @@ -953,8 +884,21 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
>  static int tegra_smmu_of_xlate(struct device *dev,
>  			       struct of_phandle_args *args)
>  {
> +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> +	struct tegra_mc *mc = platform_get_drvdata(iommu_pdev);
>  	u32 id = args->args[0];
>  
> +	/*
> +	 * Note: we are here releasing the reference of &iommu_pdev->dev, which
> +	 * is mc->dev. Although some functions in tegra_smmu_ops may keep using
> +	 * its private data beyond this point, it's still safe to do so because
> +	 * the SMMU parent device is the same as the MC, so the reference count
> +	 * isn't strictly necessary.
> +	 */
> +	put_device(&iommu_pdev->dev);
> +
> +	dev_iommu_priv_set(dev, mc->smmu);
> +
>  	return iommu_fwspec_add_ids(dev, &id, 1);
>  }
>  
> @@ -1079,16 +1023,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>  	if (!smmu)
>  		return ERR_PTR(-ENOMEM);
>  
> -	/*
> -	 * This is a bit of a hack. Ideally we'd want to simply return this
> -	 * value. However the IOMMU registration process will attempt to add
> -	 * all devices to the IOMMU when bus_set_iommu() is called. In order
> -	 * not to rely on global variables to track the IOMMU instance, we
> -	 * set it here so that it can be looked up from the .probe_device()
> -	 * callback via the IOMMU device's .drvdata field.
> -	 */
> -	mc->smmu = smmu;
> -
>  	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
>  
>  	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
