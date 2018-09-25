From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Date: Tue, 25 Sep 2018 16:41:21 +0300
Message-ID: <c803c9bb-dc98-0c5b-791c-0569f1d6346f@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com> <20180924105246.GM21032@ulmo>
 <a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com> <20180925100330.GF7097@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925100330.GF7097@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/25/18 1:03 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 09:57:10PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 1:52 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
>>>> GART is a part of the Memory Controller driver that is always built-in,
>>>> hence there is no benefit from the use of managed resources.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/iommu/tegra-gart.c | 12 +++++++-----
>>>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> One benefit would be cleanup on probe error. Also, we may eventually
>>> want to make even the memory controller driver buildable as a module.
>>
>> Please, let's keep that patch as is and re-introduce devm once it will
>> become really relevant.
> 
> Alright, fine with me.

Thanks, I'm taking that as ACK.
