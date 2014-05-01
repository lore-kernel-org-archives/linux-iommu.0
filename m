From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v12 18/31] iommu/exynos: allow having multiple System MMUs
	for a master H/W
Date: Thu, 01 May 2014 23:10:50 +0900
Message-ID: <20140501231050.81390a28ca44f97499a5e22e@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<1398584283-22846-19-git-send-email-shaik.ameer@samsung.com>
	<535E2F96.908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <535E2F96.908-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 28 Apr 2014 16:08:14 +0530, Tushar Behera wrote:
> On 04/27/2014 01:07 PM, Shaik Ameer Basha wrote:
> > From: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > 
> > Some master device descriptor like fimc-is which is an abstraction
> > of very complex H/W may have multiple System MMUs. For those devices,
> > the design of the link between System MMU and its master H/W is needed
> > to be reconsidered.
> > 
> > A link structure, sysmmu_list_data is introduced that provides a link
> > to master H/W and that has a pointer to the device descriptor of a
> > System MMU. Given a device descriptor of a master H/W, it is possible
> > to traverse all System MMUs that must be controlled along with the
> > master H/W.
> > 
> > Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Since you are posting the patches, you should also add your
> Signed-of-by.
>
> > ---
> >  drivers/iommu/exynos-iommu.c |  545 ++++++++++++++++++++++++++----------------
> >  1 file changed, 335 insertions(+), 210 deletions(-)
> > 
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index fefedec3..c2e6365 100755
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> 
> [ ... ]
> 
> >  static int sysmmu_pm_genpd_save_state(struct device *dev)
> > @@ -1215,7 +1349,7 @@ static int sysmmu_pm_genpd_save_state(struct device *dev)
> >  		ret = cb(dev);
> >  
> >  	if (ret == 0)
> > -		sysmmu_save_state(client->sysmmu);
> > +		sysmmu_save_state(dev);
> >  
> 
> client is now unused, remove the variable.
> 
> >  	return ret;
> >  }
> > @@ -1238,13 +1372,13 @@ static int sysmmu_pm_genpd_restore_state(struct device *dev)
> >  	if (!cb && dev->driver && dev->driver->pm)
> >  		cb = dev->driver->pm->runtime_resume;
> >  
> > -	sysmmu_restore_state(client->sysmmu);
> > +	sysmmu_restore_state(dev);
> >  
> >  	if (cb)
> >  		ret = cb(dev);
> >  
> >  	if (ret)
> > -		sysmmu_save_state(client->sysmmu);
> > +		sysmmu_restore_state(dev);
> >  
> 
> client is now unused, remove the variable.
> 

Ok.

Thanks.

KyongHo
