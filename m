From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] AMD IOMMU: iommu_set_device_table() must not be __init
Date: Thu, 8 Mar 2012 11:38:13 +0100
Message-ID: <20120308103813.GP10684@amd.com>
References: <4F5882B502000078000770CE@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F5882B502000078000770CE-ce6RLXgGx+vWGUEhTRrCg1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jan Beulich <JBeulich-IBi9RG/b67k@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 08, 2012 at 08:58:13AM +0000, Jan Beulich wrote:
> This function is called from enable_iommus(), which in turn is used
> from amd_iommu_resume().
> 
> Signed-off-by: Jan Beulich <jbeulich-IBi9RG/b67k@public.gmane.org>
> 
> ---
>  drivers/iommu/amd_iommu_init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 3.3-rc6/drivers/iommu/amd_iommu_init.c
> +++ 3.3-rc6-amd-iommu-sections/drivers/iommu/amd_iommu_init.c
> @@ -275,7 +275,7 @@ static void iommu_set_exclusion_range(st
>  }
>  
>  /* Programs the physical address of the device table into the IOMMU hardware */
> -static void __init iommu_set_device_table(struct amd_iommu *iommu)
> +static void iommu_set_device_table(struct amd_iommu *iommu)
>  {
>  	u64 entry;

Applied to iommu/fixes, thanks Jan.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
