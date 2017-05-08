From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only
Date: Mon, 8 May 2017 12:22:07 -0600
Message-ID: <CAD8Lp46afzjYKyZqjVuLJ5pTV-PHU64d=mbwNgyWgcdq23iWjw@mail.gmail.com>
References: <20170322112242.GK29659@8bytes.org>
	<1490595427-11979-1-git-send-email-arindam.nath@amd.com>
	<CAD8Lp46RjsUJEvCR5qVY6p8za5H9iDGTAyJMDd1zO7gbgBvqfA@mail.gmail.com>
	<MWHPR12MB15186B0A864F247BFBEF8EAD9C340@MWHPR12MB1518.namprd12.prod.outlook.com>
	<CAD8Lp47VQ0X0ydsGMrpTu-y4LAXfg9N7+Mzb0hDWDsKc2P-kQg@mail.gmail.com>
	<MWHPR12MB15183AFF01D7D74109CC62FF9C0A0@MWHPR12MB1518.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <MWHPR12MB15183AFF01D7D74109CC62FF9C0A0-Gy0DoCVfaSXKu+HfpMNLNQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Cc: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 5, 2017 at 9:01 AM, Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org> wrote:
>
> >-----Original Message-----
> >From: Daniel Drake [mailto:drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org]
> >Sent: Thursday, March 30, 2017 7:15 PM
> >To: Nath, Arindam
> >Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Deucher, Alexander; Bridgman, John; amd-
> >gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit,
> >Suravee; Linux Upstreaming Team
> >Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only
> >
> >On Thu, Mar 30, 2017 at 12:23 AM, Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
> >wrote:
> >> Daniel, did you get chance to test this patch?
> >
> >Not yet. Should we test it alone or alongside "PCI: Blacklist AMD
> >Stoney GPU devices for ATS"?
>
> Daniel, any luck with this patch?

Sorry for the delay. The patch appears to be working fine.

Daniel
