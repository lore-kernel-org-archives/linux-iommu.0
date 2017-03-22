From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [iommu:core 3/3] drivers/iommu/iova.c:36: error: redefinition of
	'init_iova_domain'
Date: Wed, 22 Mar 2017 22:57:25 +0100
Message-ID: <20170322215725.GG8329@suse.de>
References: <201703230212.uKXA27d6%fengguang.wu@intel.com>
	<20170322183651.GA27374@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170322183651.GA27374-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 22, 2017 at 07:36:52PM +0100, Thierry Reding wrote:
> *sigh* I think I messed up the #ifdef line. The attached .config has
> CONFIG_IOMMU_IOVA=m, which means that the #ifdef won't be true. I think
> the proper fix would be to:
> 
> -#ifdef CONFIG_IOMMU_IOVA
> +#ifdef IS_ENABLED(CONFIG_IOMMU_IOVA)
> 
> Joerg, can you fix that up yourself or do you want me to resend the
> patch with the fix rolled in?

I'll fix that up tomorrow.
