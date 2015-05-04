From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Any side effect if turn off amd_iommu
Date: Mon, 4 May 2015 13:08:02 +0200
Message-ID: <20150504110802.GE15736@8bytes.org>
References: <CAFv23QmxQ3vJnMEGN0TNR3vLAx1MN7ptB0y3QQLKciqfT3OBsQ@mail.gmail.com>
	<20150325140410.GS4441@8bytes.org>
	<CAFv23Qn93z4pE6RtURgoiBADpgCWZ6gfpMPn3akfJibudRi+Qg@mail.gmail.com>
	<20150326120547.GU4441@8bytes.org>
	<CAFv23QnUO+w0EXUx8DtgPx0W=fz37_R04EW6P-g+PF_y_U1dfA@mail.gmail.com>
	<20150330160910.GZ4441@8bytes.org>
	<CAFv23QmOjFb9NgLY0aW55OpQSecFA83jNOU1TY7o3qWuft1_Cw@mail.gmail.com>
	<CAFv23Q==+tXTif9uQfyTHE28hxGt80WYS=A6qN7q0Q4q7re6kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFv23Q==+tXTif9uQfyTHE28hxGt80WYS=A6qN7q0Q4q7re6kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: AceLan Kao <acelan.kao-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Acelan,

On Thu, Apr 23, 2015 at 10:15:33AM +0800, AceLan Kao wrote:
> We can confirm that the issue comes from the resources conflict,
> adding this boot option can solve the issue.
>    ivrs_ioapic[5]=00:00.1
> We've tried to negotiate with the OEM BIOS team, but they refused to
> modify the BIOS code, since there is no issue on MS Windows and it'll
> require to re-start a full test if the BIOS code is changed, so they
> don't want to do that.
> 
> I'm wondering if we can add a quirk to list those machine and assign
> them the correct ivrs_ioapic value in amd_iommu driver?

It is probably hard to match a specific machine which has the bug. What
do you think would be a good indicator to check whether this BIOS bug is
present?


	Joerg
