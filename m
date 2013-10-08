From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra-smmu: Staticize tegra_smmu_pm_ops
Date: Tue, 8 Oct 2013 14:07:53 +0300
Message-ID: <20131008140753.0c8a2972848be518d5e48552@nvidia.com>
References: <1381229464-28017-1-git-send-email-sachin.kamat@linaro.org>
	<1381229464-28017-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381229464-28017-2-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 8 Oct 2013 12:51:04 +0200
Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> 'tegra_smmu_pm_ops' is used only in this file. Make it static.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
