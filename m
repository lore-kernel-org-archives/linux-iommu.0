From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Exynos IOMMU driver doesn't work?
Date: Fri, 9 Jan 2015 15:31:18 +0800
Message-ID: <CAOhR-w1gH6zzSZcw-0Lo0zc+p1Mt0=4aqWEZ0Agz4xw0uHsq7A@mail.gmail.com>
References: <CAOhR-w2vQbyYrWsvZjs-Pt6tU6m9BmH-T5tuBDSyUXteWgxP0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOhR-w2vQbyYrWsvZjs-Pt6tU6m9BmH-T5tuBDSyUXteWgxP0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list.

On 7 January 2015 at 18:31, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Hi Cho KyongHo, Joerg et al,
> I found the latest Exynos IOMMU driver doesn't work, the line 481:
> BUG_ON(!has_sysmmu(dev));
> in function __exynos_sysmmu_enable() in file exynos-iommu.c triggers
> kernel panic.
>
> Then I found the dev->archdata.iommu isn't initialized at all, it
> should be the root cause.
>
> Am I right? any comment, solution?
>
> Another problem is this driver is added support of device tree, but
> there is no device tree nodes in the dts file, so I had to search from
> internet and added those nodes manually.
>
> I've found these links of v12 and v13 patches
> https://lkml.org/lkml/2014/4/27/171
> https://lkml.org/lkml/2014/5/12/34
> patch v13 was merged into mainline kernel, but as a part of v12, it
> isn't complete and doesn't work alone, eg dts nodes are missing.
> (I didn't research much dev->archdata.iommu initialization error is
> introduced by which patch, but it seems in very old codes there is no
> such problem)
>
> Thanks.
